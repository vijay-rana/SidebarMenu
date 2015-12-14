//
//  ViewController.swift
//  MedicalForm
//
//  Created by KBS on 08/09/15.
//  Copyright (c) 2015 KBS. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

    
    
    
    var list:Array<String> = []
    var HearAboutDicLst = [String: String]()
    var HearAboutID = ""
    var HearAboutText = ""
    var Client:ClientDetailDTO = ClientDetailDTO()
    
    var strDOB = ""
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtTelephone: UITextField!
    //@IBOutlet weak var txtNextOfKin: UITextField!
    //@IBOutlet weak var txtNextOfKinTelephone: UITextField!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var pickerHearAbout: UIPickerView!
    
    @IBOutlet weak var svClientDetail: UIScrollView!
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var lblSwtichText: UILabel!
    
    @IBOutlet weak var dtDOB: UIDatePicker!
   
    
    @IBOutlet weak var swtNewsletters: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LocalDB()
        
        //ClearField()
        
        Segue.SegueId = String(SegueId.Open_Client)
        
       
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        GetHearAboutList()
        TapGesture()
        AssignDelegates()
        swtNewsletters.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        txtTelephone.keyboardType = UIKeyboardType.NumberPad
        //txtNextOfKinTelephone.keyboardType = UIKeyboardType.NumberPad
        
        BindDetails()
        
        //if(ClientDTO.client_id > 0)
        //{
            //GetClientDetail()
            //BindDetails()
        //}
        
    }
    
    func TapGesture()
    {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //////////////////////////////////////
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func DismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    func ClearField()
    {
            txtFirstName.text == ""
            txtLastName.text == ""
            txtTelephone.text == ""
            //txtNextOfKin.text == ""
            //txtNextOfKinTelephone.text == ""
            txtEmail.text == ""
    }
    
    func AssignDelegates()
    {
        txtFirstName.delegate = self;
        txtLastName.delegate = self;
        txtTelephone.delegate = self;
        //txtNextOfKin.delegate = self;
        //txtNextOfKinTelephone.delegate = self;
        txtEmail.delegate = self;
        
        
    }
    
   
    
    func numberOfComponentsInPickerView(pickerHearAbout: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerHearAbout: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(pickerHearAbout: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return list[row]
        
    }
    func pickerView(pickerHearAbout: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        let SelectText = list[row]
        HearAboutID = HearAboutDicLst[SelectText]!
        
    }
    
    func GetHearAboutList()
    {
        if(Collection.Static_list.count <= 0 && Collection.Static_HearAboutDicLst.count <= 0)
        {
            let client = ClientRequest()
            Collection.Static_list.append("--Select--")
            Collection.Static_HearAboutDicLst["--Select--"] = "0"
            let anyObj: AnyObject? =  client.SynchronousRequest("/Hear_about_list.php")
            if(anyObj != nil && anyObj is Array<AnyObject>)
            {
                for json in anyObj as! Array<AnyObject>{
                    Collection.Static_list.append((json["hear_txt"] as AnyObject? as? String) ?? "")
                    Collection.Static_HearAboutDicLst[(json["hear_txt"] as AnyObject? as? String) ?? ""] = (json["from_id"] as AnyObject? as? String) ?? "";
                    
                }// for
            }
        }
        list = Collection.Static_list
        HearAboutDicLst = Collection.Static_HearAboutDicLst
    }
    func stateChanged(switchState: UISwitch) {
        if swtNewsletters.on {
            lblSwtichText.text = "Yes"
            
        } else {
            lblSwtichText.text = "No"
            
        }
    }
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    func ActivityIndicator()
    {
        indicator.frame =  CGRectMake(305, 362, 100, 100)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.bringSubviewToFront(self.view)
    }
    func StartAnimating()
    {
        indicator.startAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
    }
    func StopAnimating()
    {
        indicator.stopAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    @IBAction func btnNext_TouchDown(sender: AnyObject) {
       
        if(ValidateData())
        {
            ClientDTO_Static.newsletter_status =  swtNewsletters.on
            ClientDTO_Static.first_name =  txtFirstName.text!
            ClientDTO_Static.last_name =   txtLastName.text!
            ClientDTO_Static.dob = strDOB
            ClientDTO_Static.telephone =  txtTelephone.text!
            ClientDTO_Static.newsletter_status =  swtNewsletters.on
            ClientDTO_Static.email =    txtEmail.text!
            
            print(HearAboutID)
            
            if(HearAboutID != "")
            {
            ClientDTO_Static.hear_frm =  Int(HearAboutID)!
            }
            else
            {
                ClientDTO_Static.hear_frm =  0
            }
           
            performSegueWithIdentifier("GotoGeneralMedicalQuestions", sender: nil)
            return
        }
    }
    
    
//    @IBAction func btnNext_TouchDown(sender: AnyObject) {
//        StartAnimating()
//        if(ValidateData())
//        {
//            print(txtLastName.text!)
//            
//            let NewslettersStatus =  swtNewsletters.on ? "1": "0"
//            let Data1 =  "&first_name=" + txtFirstName.text! + "&last_name="
//            let Data2 =   txtLastName.text! + "&dob=" + strDOB + "&telephone=" +  txtTelephone.text!
//            let Data3 = "&newsletter_status=" + NewslettersStatus + "&email="
//            let Data4 =  txtEmail.text! + "&kin_name=" + ""
//            let Data5 = "&kin_telephone=" +  "" + "&hear_frm=" + HearAboutID
//            var id = ""
//            if(ClientDTO.client_id > 0)
//            {
//                id = "&clientid=" + String(ClientDTO.client_id)
//            }
//            let Data = Data1 +  Data2 + Data3 +  Data4 + Data5  + id
//            
//            
//            let client = ClientRequest()
//            client.PostDataAsyc("/clientDetail_save.php", data: Data)
//            StopAnimating()
//            performSegueWithIdentifier("GotoGeneralMedicalQuestions", sender: nil)
//            return
//        }
//    }

    
    
    func SaveClientDetail()
    {
        let client = ClientRequest()
        client.SynchronousRequest("/Hear_about_list.php" )
    }
    
    
    func ValidateData  () -> Bool
    {
        if( txtFirstName.text == "" ||
        txtLastName.text == "" ||
        txtTelephone.text == "" )
        {
            Error("Fileds with (*) are required!")
            return false
        }
     
        if( strDOB == "" )
        {
            Error("It seems like you didn't select date of birth accurately. Please select your DOB")
            return false
        }
        
        if(!txtEmail.text!.isEmpty && !isValidEmail(txtEmail.text!))
        {
            Error("Email entered by you is not a valid email address!")
            return false;
        }
        
        return true
    }
    
    @IBAction func datePickerAction(sender: AnyObject) {
       let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        strDOB = dateFormatter.stringFromDate(dtDOB.date)
        
    }
    
    
    
    
    func Error(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    func isValidEmail(testStr:String) -> Bool {
       
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let scrollPoint: CGPoint = CGPointMake(0, textField.frame.origin.y - 150)
        svClientDetail.setContentOffset(scrollPoint, animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        svClientDetail.setContentOffset(CGPointZero, animated: true)
    }
    
    
    
    func GetClientDetail()
    {
        let client = ClientRequest()
        let anyObj: AnyObject? =  client.SynchronousRequest("/ClientById.php?clientid=" + String(ClientDTO.client_id))
        if(anyObj != nil && anyObj is Array<AnyObject>)
        {
            for json in anyObj as! Array<AnyObject>{
                
                
                Client.first_name  = (json["first_name"] as AnyObject? as? String) ?? ""
                Client.last_name = (json["last_name"] as AnyObject? as? String)! ?? ""
                Client.telephone = (json["telephone"] as AnyObject? as? String)! ?? ""
                Client.dob = (json["dob"] as AnyObject? as? String)! ?? ""
                let id = (json["clientid"] as AnyObject? as? String)! ?? ""
                if(id != "")
                {
                    Client.clientid = Int(id)!
                }
                Client.email = (json["email"] as AnyObject? as? String)! ?? ""                  
                let hear_frm = (json["hear_frm"] as AnyObject? as? String)! ?? ""
                if(hear_frm != "")
                {
                    Client.hear_frm = Int(hear_frm)!
                }
                
                let newsletter_status = (json["newsletter_status"] as AnyObject? as? String)! ?? ""
                if(newsletter_status != "")
                {
                   Client.newsletter_status = toBool(newsletter_status)!
                }
                
                Client.kin_name = (json["kin_name"] as AnyObject? as? String)! ?? ""
                Client.kin_telephone = (json["kin_telephone"] as AnyObject? as? String)! ?? ""
                break
            }// for
        }
    }
    
    func toBool(str: String) -> Bool? {
        switch str {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return false
        }
    }

   
    
    
    func BindDetails()
    {
        
        
        txtFirstName.text = ClientDTO_Static.first_name
        txtLastName.text = ClientDTO_Static.last_name
        txtTelephone.text = ClientDTO_Static.telephone
        txtEmail.text = ClientDTO_Static.email
        //txtNextOfKin.text = Client.kin_name
        //txtNextOfKinTelephone.text = Client.kin_telephone
        swtNewsletters.on = ClientDTO_Static.newsletter_status
        
        //let keys = (HearAboutDicLst as NSDictionary).allKeysForObject(String(Client.hear_frm)) as! [String]
        //HearAboutText = String(stringInterpolationSegment: keys)
        
        HearAboutID = String(ClientDTO_Static.hear_frm)
        pickerHearAbout.selectRow(ClientDTO_Static.hear_frm, inComponent: 0, animated: true)
        
        if(ClientDTO_Static.dob != "")
        {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let convertedStartDate = dateFormatter.dateFromString(ClientDTO_Static.dob)
            dtDOB.date = convertedStartDate!
            strDOB = ClientDTO_Static.dob
        }
        
    }
    
    
    func LocalDB()
    {
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        
       
        
        let path = "sdfs" //documentsFolder.stringByAppendingPathComponent("Ice.sqlite")
        
        print(path)
        
        let database = FMDatabase(path: path)
        
        if !database.open() {
            print("Unable to open database")
            return
        }
        
        
        if !database.executeUpdate("CREATE TABLE CLIENT(ID INTEGER PRIMARY KEY   AUTOINCREMENT,query TEXT NULL, data TEXT NULL)", withArgumentsInArray: nil) {
            print("create table failed: \(database.lastErrorMessage())")
        }
        
       
        
//        if !database.executeUpdate("create table test(x text, y text, z text)", withArgumentsInArray: nil) {
//            println("create table failed: \(database.lastErrorMessage())")
//        }
//        
//        if !database.executeUpdate("insert into CLIENT (query, data) values (?, ?)", withArgumentsInArray: ["query1", "data1"]) {
//            println("insert 1 table failed: \(database.lastErrorMessage())")
//        }
//
//        if !database.executeUpdate("insert into CLIENT (query, data) values (?, ?)", withArgumentsInArray: ["query2", "data2"]) {
//            println("insert 2 table failed: \(database.lastErrorMessage())")
//        }
        
        if let rs = database.executeQuery("select ID, query, data from CLIENT", withArgumentsInArray: nil) {
            while rs.next() {
                let x = rs.stringForColumn("ID")
                let y = rs.stringForColumn("query")
                let z = rs.stringForColumn("data")
                print("x = \(x); y = \(y); z = \(z)")
            }
        } else {
            print("select failed: \(database.lastErrorMessage())")
        }
        
        database.close()
    }
    
    @IBAction func txtTelephone_EditingChanged(sender: AnyObject) {
       
         txtTelephone.text = NumberOnly(txtTelephone.text!)
      
    }
    
    @IBAction func txtNextOfKinTelephone_EditingChanged(sender: AnyObject) {
        //txtNextOfKinTelephone.text = NumberOnly(txtNextOfKinTelephone.text!)
    }
    
    
    @IBAction func txtFirstName_EditingChanged(sender: AnyObject) {
        if(txtFirstName.text!.characters.count == 1)
        {
            txtFirstName.text = txtFirstName.text!.capitalizedString
        }
    }
    
    @IBAction func txtLastName_EditingChanged(sender: AnyObject) {
        if(txtLastName.text!.characters.count == 1)
        {
            txtLastName.text = txtLastName.text!.capitalizedString
        }
    }
    
    
    
    func NumberOnly(strPhone: String) -> String
    {
        if(strPhone.characters.count == 0)
        {
            return strPhone
        }
        var phone: String = strPhone
        let lastChar = phone.characters.last!
        
        if(Int(String(lastChar)) == nil)
        {
           phone = String(phone.characters.dropLast())
           Error("Only numbers are allowed!")
        }
       
        return phone
    }
}

