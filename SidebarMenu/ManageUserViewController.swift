
//
//  GeneralMedicalQuestionsViewController.swift
//  SidebarMenu
//
//  Created by KBS on 14/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

class ManageUserViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource
{
    var strDate = ""
    
    var RoleID:String = ""
    var user_id:Int = 0
    var listUserRole:Array<String> = ["--select--","user", "admin", "client"]
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var txtUsername: UITextField!
   
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtRetypepassword: UITextField!
    
    @IBOutlet weak var txtAccessKey: UITextField!
    
    @IBOutlet weak var pvRole: UIPickerView!
    
    @IBOutlet weak var btnDelete: UIButton!
    var items:Array<UserDTO> = []
    let MyKeychainWrapper = KeychainWrapper()
    
    
    @IBOutlet weak var tvUsers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Segue.SegueId = String(SegueId.Open_ManageUser)
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        TapGesture()
        AssignDelegate()
        GetUserList()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshUserList:", name:"refreshUserTableView", object: nil)
        
    }
    
    func TapGesture()
    {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func DismissKeyboard() {
        self.view.endEditing(true)
        HideButton()
    }

    
    func refreshUserList(notification: NSNotification){
        ClientDTO.note_id = 0
        items.removeAll(keepCapacity: false)
        GetUserList()
        tvUsers.reloadData()
    }
    
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    
    
    
    
    
    
    func AssignDelegate()
    {
        tvUsers.delegate = self
        tvUsers.dataSource = self
        txtUsername.delegate = self
        txtPassword.delegate = self
        txtAccessKey.delegate = self
        txtRetypepassword.delegate = self
        
    }
    
    
    
    func Error(message: String)
    {
        
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    
    func Success(message: String)
    {
        
        let alert = UIAlertView()
        alert.title = "Success"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    
    
   
    @IBAction func btnSave_TouchDown(sender: AnyObject) {
        
        if(String(stringInterpolationSegment: MyKeychainWrapper.myObjectForKey("svce")) == "2")
        {
            if(txtPassword.text != txtRetypepassword.text)
            {
                Error("Password and Retype password must be the same")
                return
            }
            if(txtPassword.text == "" || txtRetypepassword.text == "" || txtAccessKey.text == "" || txtUsername.text == "")
            {
                Error("All fields are required")
                return
            }

            var Data1 =  "&username=" + txtUsername.text! + "&password=" +  txtPassword.text!
            var Data2  = "&roll_id=" + RoleID + "&quick_access=" +  txtAccessKey.text!
            var Data = Data1 +  Data2
            
            var client = ClientRequest()
            client.PostDataAsyc("/SaveUsers.php", data: Data)
            self.Success("Record added successfully, List will update in few seconds.")
            return
        }
        else
        {
            Error("You don't have permision for this activity")
            return
        }
        
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return listUserRole.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
            return listUserRole[row]
    }
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        let SelectText = listUserRole[row]
        if(SelectText == "user")
        {
            RoleID = "1"
        }
        else if (SelectText == "admin")
        {
            RoleID = "2"
        }
        else if (SelectText == "client")
        {
            RoleID = "3"
        }
        else
        {
            RoleID = ""
        }
    }
    
    
    
    func tableView(tvUsers: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count + 1;
    }
    
    func tableView(tvUsers: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0)
        {
            let cell = tvUsers.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
            
            cell.UserName.font = UIFont.boldSystemFontOfSize(22.0)
            cell.UserName.text = "User Name"
            
            
            cell.Password.font = UIFont.boldSystemFontOfSize(22.0)
            cell.Password.text = "Password"
            
            cell.Role.font = UIFont.boldSystemFontOfSize(22.0)
            cell.Role.text = "Role"
            
            cell.QuickAccess.font = UIFont.boldSystemFontOfSize(22.0)
            cell.QuickAccess.text =  "Quick Access"
            
            return cell
        }
        else
        {
            let f: CGFloat = 17.0
            let cell = tvUsers.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
            
            cell.UserName.text = self.items[indexPath.row - 1].username
            cell.UserName.font = UIFont.systemFontOfSize(f)
            
           
            cell.Password.text = self.items[indexPath.row - 1].password
            cell.Password.font = UIFont.systemFontOfSize(f)
            
            if(self.items[indexPath.row - 1].roll_id == 2)
            {
                cell.Role.text = "admin"
                
            }
            else if(self.items[indexPath.row - 1].roll_id == 1)
            {
                cell.Role.text = "user"
            }
            else if(self.items[indexPath.row - 1].roll_id == 3)
            {
                cell.Role.text = "client"
            }
                
            else
            {
                cell.Role.text = ""
            }
            
            
            cell.QuickAccess.text = self.items[indexPath.row - 1].quick_access
            cell.QuickAccess.font = UIFont.systemFontOfSize(f)
            
          
            
            return cell
        }
    }
    
    func tableView(tvUsers: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row > 0)
        {
            user_id = self.items[indexPath.row - 1].userid
            ShowButton()
        }
        else
        {
            user_id = 0
            HideButton()
            
        }
       
    }
    
    
    func GetUserList()
    {
        let client = ClientRequest()
        let anyObj: AnyObject? =  client.SynchronousRequest("/UsersList.php")
        if(anyObj != nil && anyObj is Array<AnyObject>)
        {
            for json in anyObj as! Array<AnyObject>{
                var b:UserDTO = UserDTO()
                b.username  = (json["username"] as AnyObject? as? String) ?? ""
                b.password = (json["password"] as AnyObject? as? String)! ?? ""
                b.quick_access = (json["quick_access"] as AnyObject? as? String)! ?? ""
                              
                let userid = (json["userid"] as AnyObject? as? String)! ?? ""
                 let roleid = (json["roll_id"] as AnyObject? as? String)! ?? ""
                if(userid != "")
                {
                    b.userid = Int(userid)!
                }
                if(roleid != "")
                {
                    b.roll_id = Int(roleid)!
                }              
                
                items.append(b)
            }// for
        }
    }
    
    func HideButton()
    {
        
        btnDelete.hidden = true
        
    }
    
    func ShowButton()
    {
       btnDelete.hidden = false
        
    }
    
    @IBAction func btnDelete_TouchDown(sender: AnyObject) {
       
        if(String(stringInterpolationSegment: MyKeychainWrapper.myObjectForKey("svce")) == "2")
        {
            if(user_id > 0)
            {
                let Data =  "&userid=" + String(user_id)
                let client = ClientRequest()
                client.PostDataAsyc("/DeleteUser.php", data: Data)
                 self.Success("Record deleted successfully, List will update in few seconds.")
            }
            return
        }
        else
        {
            Error("You don't have permision for this activity")
            return
        }

    }
}