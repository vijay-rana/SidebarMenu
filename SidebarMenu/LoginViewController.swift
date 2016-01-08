//
//  LoginViewController.swift
//  SidebarMenu
//
//  Created by KBS on 10/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
   
    @IBOutlet weak var txtUserId: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    var list:Array<UserDTO> = []
   // var listRequests:Array<String> = ["/Hear_about_list.php","/SkinTypeValues.php", "/Therapist.php", "/TherapistAreaRecord.php", "/TherapistValues.php","/colors.php"]
    let MyKeychainWrapper = KeychainWrapper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(CheckReturningUser())
        {
           self.view.hidden = true
        }
        TapGesture()
        AssignDelegate()
        ActivityIndicator()
    }
    
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    func ActivityIndicator()
    {
        indicator.frame =  CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 50, 100, 100)
        indicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha:0.7)
        indicator.layer.cornerRadius = 10
        self.view.addSubview(indicator)
    
    }
    func StartAnimating()
    {
        indicator.startAnimating()
    
    }
    func StopAnimating()
    {
        indicator.stopAnimating()
       
    }
       
    
    
    override func viewDidAppear(animated: Bool) {
        if(CheckReturningUser())
        {
            super.viewDidAppear(animated)
            performSegueWithIdentifier("GotoQuickAccess", sender: nil)
            return
        }
    }
    
   
    
    @IBAction func btnLogin_TouchDown(sender: AnyObject) {
        // for testing start
        // for tesing end
        
        if(txtUserId.text == "" || txtPassword.text == "")
        {
            Error("Username and password is required!");
            return
        }        
        
     StartAnimating()
     let client = ClientRequest()
        
     var anyObj: AnyObject? = ClientRequest()
     
        backgroundThread(0.0, background: {
            
             anyObj =  client.SynchronousRequest("/login.php?username=" + self.txtUserId.text!+"&password=" +  self.txtPassword.text!)
            
            
            }, completion: {
        
            if(anyObj != nil)
            {
                self.list = self.parseJsonUserDTO(anyObj!)
                let count  = self.list.count
                if(count > 0)
                {
                    self.MyKeychainWrapper.mySetObject(self.txtPassword.text, forKey:kSecValueData)
                    self.MyKeychainWrapper.writeToKeychain()
                    
                    self.MyKeychainWrapper.mySetObject(self.txtUserId.text, forKey:kSecAttrAccount)
                    self.MyKeychainWrapper.writeToKeychain()
                    
                    self.MyKeychainWrapper.mySetObject(self.list[0].roll_id, forKey:kSecAttrService)
                    self.MyKeychainWrapper.writeToKeychain()
                    
                    self.MyKeychainWrapper.mySetObject(self.list[0].quick_access, forKey:kSecAttrLabel)
                    self.MyKeychainWrapper.writeToKeychain()
                    User.QuickAccess = self.list[0].quick_access
                   self.StopAnimating()
                    self.performSegueWithIdentifier("GotoRevealController", sender: nil)
                    
                }
                else
                {
                    self.Error("Username/Password is not correct")
                    self.StopAnimating()
                    return
                }
            }
            else
            {
                self.Error("Some technical error accured, Please try after some time.")
                return
            }

        
        })
        
//        if(anyObj != nil)
//        {
//            list = self.parseJsonUserDTO(anyObj!)
//            let count  = list.count
//            if(count > 0)
//            {
//                MyKeychainWrapper.mySetObject(txtPassword.text, forKey:kSecValueData)
//                MyKeychainWrapper.writeToKeychain()
//                
//                MyKeychainWrapper.mySetObject(txtUserId.text, forKey:kSecAttrAccount)
//                MyKeychainWrapper.writeToKeychain()
//                
//                MyKeychainWrapper.mySetObject(list[0].roll_id, forKey:kSecAttrService)
//                MyKeychainWrapper.writeToKeychain()
//                
//                MyKeychainWrapper.mySetObject(list[0].quick_access, forKey:kSecAttrLabel)
//                MyKeychainWrapper.writeToKeychain()
//                User.QuickAccess = list[0].quick_access
//                
//                
////                var client = ClientRequest()
////                if(!client.ValidateMasterData())
////                {
////                    CreateMasterTableData()
////                }
//                
////                if(list[0].roll_id == 1)
////                {
////                    Warning("You can only view the data, Your changes will not be saved.")
////                }
//                
//               
//                performSegueWithIdentifier("GotoRevealController", sender: nil)
//                
//            }
//            else
//            {
//                Error("Username/Password is not correct")
//                StopAnimating()
//                return
//            }
//        }
//        else
//        {
//           Error("Some technical error accured, Please try after some time.")
//            return
//        }
//        
    
        
    }
    
    
    
    func CheckReturningUser() -> Bool
    {
        var password = ""
        var username = ""
        
        print(MyKeychainWrapper.myObjectForKey("acct"))
        print(MyKeychainWrapper.myObjectForKey("v_Data"))
        print(MyKeychainWrapper.myObjectForKey("svce"))
        print(MyKeychainWrapper.myObjectForKey("labl"))
        
        if(MyKeychainWrapper.myObjectForKey("acct") != nil && MyKeychainWrapper.myObjectForKey("v_Data") != nil)
        {
            password = MyKeychainWrapper.myObjectForKey("v_Data") as! String
            username = MyKeychainWrapper.myObjectForKey("acct") as! String
        }
        if(username.isEmpty || password.isEmpty)
        {
            return false
        }
        return true
    }
    
    
    
    func Error(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    func Warning(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Warning"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
   
    func TapGesture()
    {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)

    }
    
    func AssignDelegate()
    {
        txtPassword.delegate = self
        txtUserId.delegate = self
    }
    func DismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    
    
    
    func parseJsonUserDTO(anyObj:AnyObject) -> Array<UserDTO>{
        
        var list:Array<UserDTO> = []
        
        if  anyObj is Array<AnyObject> {
            
            var b:UserDTO = UserDTO()
            
            for json in anyObj as! Array<AnyObject>{
                b.username = (json["username"] as AnyObject? as? String) ?? ""
                b.userid  =  (json["userid"]  as AnyObject? as? Int) ?? 0
                b.password = (json["password"] as AnyObject? as? String) ?? ""
                
                let roleid = (json["roll_id"] as AnyObject? as? String)! ?? ""
                if(roleid != "")
                {
                 b.roll_id = Int(roleid)!
                }
                b.quick_access = (json["quick_access"] as AnyObject? as? String) ?? ""
                b.status = (json["status"] as AnyObject? as? String) ?? ""
                b.add_date = (json["add_date"] as AnyObject? as? String) ?? ""
                list.append(b)
            }// for
            
        } // if
        
        return list
        
    }//func
    
    
    
    //method for multi threading  -----------
    
    func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            if(background != nil){ background!(); }
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
    
    
    
//    func CreateMasterTableData()
//    {
//        var client = ClientRequest()
//        for query in listRequests as Array<String>{
//            client.ServerToLocalDB(query)
//        }// for
//    }
}








