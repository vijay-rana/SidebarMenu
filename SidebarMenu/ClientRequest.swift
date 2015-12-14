//
//  ClientRequest.swift
//  SidebarMenu
//
//  Created by KBS on 10/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation
import UIKit

class ClientRequest: NSObject {
    
    var data = NSMutableData()    
    
    
     
    
//    func ServerToLocalDB(query:NSString)
//    {
//        let nilObj: AnyObject? = nil
//        let MyKeychainWrapper = KeychainWrapper()
//      
//        
//        if let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist") {
//            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
//                var GlobalURL: String =  (dict["GlobalURL"]! as! String) + (query as String) as String as! String
//                var url = NSURL(string: GlobalURL)
//                var request = NSURLRequest(URL: url!) // Creating Http Request
//                
//                
//                var response:AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil;
//                var error: AutoreleasingUnsafeMutablePointer<NSErrorPointer> = nil;
//                // Sending Synchronous request using NSURLConnection
//                var responseData = NSURLConnection.sendSynchronousRequest(request,returningResponse: response, error:nil) as NSData?
//                
//                
//                
//                if error != nil
//                {
//                    // You can handle error response here
//                }
//                else
//                {
//                    //println(responseData)
//                    //Converting data to String
//                    // var responseStr:NSString = NSString(data:responseData!, encoding:NSUTF8StringEncoding)!
//                    var jsonString: NSString = NSString(data: responseData!, encoding: NSUTF8StringEncoding)!
//                    //println(jsonString)
//                    insertMasterData(query as String,data: jsonString as String)
//                }
//            }
//        }   
//        
//    }

    
    
    
    
    func SynchronousRequest(query:NSString) -> AnyObject?
    {
        let nilObj: AnyObject? = nil
        let MyKeychainWrapper = KeychainWrapper()
        
        if let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                let GlobalURL: String =  (dict["GlobalURL"]! as! String) + (query as String) as String as String
                
                //println(GlobalURL)
                
                let url = NSURL(string: GlobalURL)
                let request = NSURLRequest(URL: url!) // Creating Http Request
                
                
                let response:AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil;
                let error: AutoreleasingUnsafeMutablePointer<NSErrorPointer> = nil;
                // Sending Synchronous request using NSURLConnection
               
                var responseData :NSData? = nil
                if(IJReachability.isConnectedToNetwork())
                {
                   responseData = (try? NSURLConnection.sendSynchronousRequest(request,returningResponse: response)) as NSData?
                   
                }
                else
                {
                    self.Error("Internet connection lost!!")
                   //responseData = GetMasterTableData(query as String)
                }
                
                if error != nil || responseData == nil
                {
                    // You can handle error response here
                }
                else
                {
                    
                    let anyObj: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(responseData!, options: NSJSONReadingOptions(rawValue: 0))
                    return anyObj
                }
               
            }
        }
      
            return nilObj
        
    }
    
    
    
    func PostDataAsyc(query:String, data:String)
  {
    let MyKeychainWrapper = KeychainWrapper()
    
    if(!IJReachability.isConnectedToNetwork())
    {
//        insertCLIENT(query, data: data)
//        ClientDTO.client_id = 999999999
        self.Error("Internet connection lost!!")
        return
    }
//    else if(ClientDTO.client_id == 999999999 )
//    {
//        ClientDTO.client_id = 0
//    }
    
    
    if let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist") {
        if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
            var GlobalURL: String =  (dict["GlobalURL"]! as! String) + query
            
             //println(GlobalURL)
            
    let request = NSMutableURLRequest(URL: NSURL(string: GlobalURL)!)
    request.HTTPMethod = "POST"
    let postString = data
    request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            
            
            
            
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
        responseData, response, error in
        
        
        
        if error != nil {
           self.Error("Some technical error occured! Your information was not saved.")
           return
        }
        
        
        if( query == "/clientDetail_save.php")
            {
                var jsonString: NSString = NSString(data: responseData!, encoding: NSUTF8StringEncoding)!
                
                jsonString = "[" + (jsonString as String) + "]"
                var dataNS: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)!
                var error: NSError?
                let anyObj: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(dataNS, options: NSJSONReadingOptions(rawValue: 0))
                for json in anyObj as! Array<AnyObject>{
                    ClientDTO_Static.clientid = (json["clientid"] as AnyObject? as? Int) ?? 0
                    
                    print(ClientDTO_Static.clientid )
                    
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName("saveClientDetailSuccess", object: nil)
        }
        
        if( query == "/DeleteClientRecord.php")
        {
           NSNotificationCenter.defaultCenter().postNotificationName("refreshMyTableView", object: nil)
        }
        
        if(query == "/DeleteTherapistNotes.php" || query == "/SaveTherapistNotes.php")
        {
            NSNotificationCenter.defaultCenter().postNotificationName("refreshTreatmentNotesTableView", object: nil)
        }
        
        if(query == "/DeleteUser.php" || query == "/SaveUsers.php")
        {
            NSNotificationCenter.defaultCenter().postNotificationName("refreshUserTableView", object: nil)
        }
        
    }
    task.resume()
            }
        }
    }
    
    
    
    
    
    
    func AsynchronousRequest(query:NSString) {
        
        if let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                let GlobalURL: String =  (dict["GlobalURL"]! as! String) + (query as String) as String 
                
                let url = NSURL(string: GlobalURL)
                
                let request = NSURLRequest(URL: url!)
                var conn = NSURLConnection(request: request, delegate: self, startImmediately: true)
                
            }
        }
    }
    
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSHTTPURLResponse!) {
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        var jsonString: NSString = NSString(data: conData, encoding: NSUTF8StringEncoding)!
        let anyObj: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(conData, options: NSJSONReadingOptions(rawValue: 0))
    
    }
    
    
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
    }
    
    
    deinit {
        //println("deiniting")
    }
    
    
    func Error(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    
//    func insertCLIENT(query:String, data:String)
//    {
//        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
//        let path = documentsFolder.stringByAppendingPathComponent("Ice.sqlite")
//        
//        println(path)
//        
//        let database = FMDatabase(path: path)
//        
//        if !database.open() {
//            println("Unable to open database")
//            return
//        }
//      
//        if !database.executeUpdate("insert into CLIENT (query, data) values (?, ?)", withArgumentsInArray: [query, data]) {
//            println("insert 2 table failed: \(database.lastErrorMessage())")
//        }
//        
//        database.close()
//    }
//  
//    
//    func insertMasterData(query:String, data:String)
//    {
//        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
//        let path = documentsFolder.stringByAppendingPathComponent("Ice.sqlite")
//        
//        println(path)
//        
//        let database = FMDatabase(path: path)
//        
//        if !database.open() {
//            println("Unable to open database")
//            return
//        }
//        
//        if !database.executeUpdate("insert into MasterData (query, data) values (?, ?)", withArgumentsInArray: [query, data]) {
//            println("insert 2 table failed: \(database.lastErrorMessage())")
//        }
//        
//        database.close()
//    }
    
   
//    func ValidateMasterData() -> Bool
//    {
//        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
//        let path = documentsFolder.stringByAppendingPathComponent("Ice.sqlite")
//        
//        println(path)
//        
//        let database = FMDatabase(path: path)
//        
//        if !database.open() {
//            println("Unable to open database")
//            return false
//        }
//        
//        if let rs = database.executeQuery("select ID, query, data from MasterData", withArgumentsInArray: nil) {
//            while rs.next() {
//                return true
//            }
//        } else {
//            println("select failed: \(database.lastErrorMessage())")
//            return false
//        }
//        
//        database.close()
//        return false
//       
//    }
    
   
//    func GetMasterTableData(query:String) -> NSData?
//    {
//        
//        let nilObj: NSData? = nil
//        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
//        let path = documentsFolder.stringByAppendingPathComponent("Ice.sqlite")
//        println(path)
//        let database = FMDatabase(path: path)
//        if !database.open() {
//            println("Unable to open database")
//            return nilObj
//        }
//        
//        if let rs = database.executeQuery("select ID, query, data from MasterData where query = '"  + query + "'", withArgumentsInArray: nil) {
//            while rs.next() {
//                println(rs.stringForColumn("data"))
//                let data = (rs.stringForColumn("data") as NSString).dataUsingEncoding(NSUTF8StringEncoding)
//                return data
//            }
//        } else {
//            println("select failed: \(database.lastErrorMessage())")
//            return nilObj!
//        }
//        
//        database.close()
//        return nilObj
//        
//    }
    
    
   
    
}
