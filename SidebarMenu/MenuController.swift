//
//  MenuController.swift
//  SidebarMenu
//
//  Created by Simon Ng on 2/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {

    let MyKeychainWrapper = KeychainWrapper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func Warning(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Warning"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        
        if(row == 9 && String(stringInterpolationSegment: MyKeychainWrapper.myObjectForKey("svce")) != "2")
        {
            ClientDTO.client_id = 0;
            ClientDTO.note_id = 0;
            User.QuickAccess = ""
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("RevealVC") as! SWRevealViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
             Warning("Access denied!")           
            
        }
        
        if(row == 10)
        {
            ClientDTO.client_id = 0;
            ClientDTO.note_id = 0;
            User.QuickAccess = ""            
            
            Reset_ClientDTO_Static()
            ResetQuestion()
            ResetTherapistDTO_Static()
            ResetAggrement()
            Collection.Static_listTreatmentNotesDTO.removeAll()
            
            
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("RevealVC") as! SWRevealViewController
//            self.presentViewController(nextViewController, animated:true, completion:nil)
        }
        if(row == 11)
        {
            MyKeychainWrapper.mySetObject("", forKey:kSecValueData)
            MyKeychainWrapper.writeToKeychain()
            
            MyKeychainWrapper.mySetObject("", forKey:kSecAttrAccount)
            MyKeychainWrapper.writeToKeychain()            
            
            MyKeychainWrapper.mySetObject("", forKey:kSecAttrService)
            MyKeychainWrapper.writeToKeychain()
            
            
            MyKeychainWrapper.mySetObject("", forKey:kSecAttrLabel)
            MyKeychainWrapper.writeToKeychain()
            
            ClientDTO.client_id = 0
            ClientDTO.note_id = 0
            
            
           
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("Login_ID") as! LoginViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            
        }
        
            
        
    }
    
    
    
    func Reset_ClientDTO_Static() {
        ClientDTO_Static.clientid  = 0
        ClientDTO_Static.first_name = ""
        ClientDTO_Static.last_name = ""
        ClientDTO_Static.dob = ""
        ClientDTO_Static.newsletter_status = false
        ClientDTO_Static.email  = ""
        ClientDTO_Static.kin_name  = ""
        ClientDTO_Static.hear_frm = 0
        ClientDTO_Static.telephone  = ""
        ClientDTO_Static.kin_telephone  = ""
        
    }
    
    
    func  ResetTherapistDTO_Static() {
        TherapistDTO_Static.skin_type1 = 0
        TherapistDTO_Static.area1   = 0
        TherapistDTO_Static.area2    = 0
        TherapistDTO_Static.area3    = 0
        TherapistDTO_Static.area4   = 0
        TherapistDTO_Static.value1     = 0
        TherapistDTO_Static.value2   = 0
        TherapistDTO_Static.value3    = 0
        TherapistDTO_Static.value4    = 0
        TherapistDTO_Static.skin_type2    = 0
        TherapistDTO_Static.hair_color    = 0
        TherapistDTO_Static.clientid    = 0
        TherapistDTO_Static.ingrow_hairs = false
        TherapistDTO_Static.comments = ""
    }

    
    
    func  ResetAggrement()
    {
        Aggrement.PatientSig = ""
        Aggrement.TherapistSig = ""
        Aggrement.Date = ""
        
    }
    
    
   
    func ResetQuestion()
    {
        Question.Q1 = ""
        Question.Q2 = ""
        Question.Q3 = ""
        Question.Q4 = ""
        Question.Q5 = ""
        Question.Q6 = ""
        Question.Q7 = ""
        Question.Q8 = ""
        Question.Q9 = ""
        Question.Q10 = ""
        Question.Q11 = ""
        Question.Q12 = ""
        Question.Q13 = ""
        Question.Q14 = ""
        Question.Q15 = ""
        Question.Q16 = ""
        Question.Q17 = ""
        Question.Q18 = ""
        Question.Q19 = ""
        Question.Q20 = ""
        Question.Q21 = ""
        Question.Q22 = ""
        Question.Q23 = ""
        Question.Q24 = ""
        Question.Q25 = ""
        Question.Q26 = ""
        Question.Q27 = ""
        Question.Q28 = ""
        Question.Q29 = ""
        Question.Q30 = ""
        Question.Q31 = ""
        Question.Q32 = ""
        Question.Q33 = ""
        
        Question.S1 = false
        Question.S2 = false
        Question.S3 = false
        Question.S4 = false
        Question.S5 = false
        Question.S6 = false
        Question.S7 = false
        Question.S8 = false
        Question.S9 = false
        Question.S10 = false
        Question.S11 = false
        Question.S12 = false
        Question.S13 = false
        Question.S14 = false
        Question.S15 = false
        Question.S16 = false
        Question.S17 = false
        Question.S18 = false
        Question.S19 = false
        Question.S20 = false
        Question.S21 = false
        Question.S22 = false
        Question.S23 = false
        Question.S24 = false
        Question.S25 = false
        Question.S26 = false
        Question.S27 = false
        Question.S28 = false
        Question.S29 = false
        Question.S30 = false
        Question.S31 = false
        Question.S32 = false
        Question.S33 = false
    }
    
    
    
    
    // MARK: - Table view data source


    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        if(indexPath.row == 10 && String(stringInterpolationSegment: MyKeychainWrapper.myObjectForKey("svce")) != "2")
//        {
//            let cell = tableView.dequeueReusableCellWithIdentifier("ManageUserCell", forIndexPath: indexPath) as! UITableViewCell
//            cell.hidden = true
//            return cell
//        }
//        else
//        {
//           return  tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!;
//        }
         //Configure the cell...
    //}
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
