//
//  GeneralMedicalQuestionsViewController.swift
//  SidebarMenu
//
//  Created by KBS on 14/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//


import UIKit
import Foundation

class ClientViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate
{
    let MyKeychainWrapper = KeychainWrapper()
    var StaticItems:Array<ClientDetailDTO> = []
    var items:Array<ClientDetailDTO> = []
    //var items: [String] = ["We", "Heart", "Swift"]
    var selectedRow: Int = 0
    
    @IBOutlet weak var tvClient: UITableView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    
   
    
    //@IBOutlet weak var btnAdd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        AssignDelegate()
        HideButton()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        tvClient!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        GetClientList()
        TapGesture()
        ActivityIndicator()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshList:", name:"refreshMyTableView", object: nil)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
//        if(Segue.SegueId.characters.count > 0)
//        {
//          self.performSegueWithIdentifier(Segue.SegueId, sender: nil)
//        }
        Segue.SegueId = "sw_front"
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

    
    
    func refreshList(notification: NSNotification){
        ClientDTO_Static.clientid = 0
        items.removeAll(keepCapacity: false)
        GetClientList()
        tvClient.reloadData()
    }
    
    var tap = UITapGestureRecognizer()
   
    func TapGesture()
    {
        tap = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    
   
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func DismissKeyboard() {
        self.view.endEditing(true)
        ClientDTO_Static.clientid = 0
        HideButton()
    }
    
    func AssignDelegate()
    {
        tvClient.delegate = self
        tvClient.dataSource = self
        txtSearch.delegate = self
    }
    
    func HideButton()
    {
        btnDelete.hidden = true
        btnEdit.hidden = true
    }
    
    func ShowButton()
    {
        if(String(stringInterpolationSegment: MyKeychainWrapper.myObjectForKey("svce")) == "1")
        {
            btnDelete.hidden = true
        }
        else
        {
            btnDelete.hidden = false
        }
        btnEdit.hidden = false
    }
    
    func tableView(tvClient: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count + 1;
    }
    
     func tableView(tvClient: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        if(indexPath.row == 0)
//        {            
//            let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "HeaderViewCell")
//            cell.textLabel?.text = "First Name              Last Name              Telephone              DOB"
//            return cell            
//        }
//        else
//        {
//            let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ClientDetailCell")
//            cell.textLabel?.text = self.items[indexPath.row - 1].first_name  + "                   " + self.items[indexPath.row - 1].last_name + "                  " + self.items[indexPath.row - 1].telephone + "                    " +  self.items[indexPath.row - 1].dob
//            return cell
//            
//        }
//        
        
        
        
        if(indexPath.row == 0)
        {
            let cell = tvClient.dequeueReusableCellWithIdentifier("ClientCell", forIndexPath: indexPath) as! ClientDetailCell
            
            cell.FirstName.font = UIFont.boldSystemFontOfSize(20.0)
            cell.FirstName.text = "First Name"
            
            cell.LastName.font = UIFont.boldSystemFontOfSize(20.0)
            cell.LastName.text = "Last Name"
            
            cell.Telephone.font = UIFont.boldSystemFontOfSize(20.0)
            cell.Telephone.text =  "Telephone"
            
            cell.DOB.font = UIFont.boldSystemFontOfSize(20.0)
            cell.DOB.text =  "DOB"
            
            return cell
        }
        else
        {
            
            let f: CGFloat = 17.0
            
            let cell = tvClient.dequeueReusableCellWithIdentifier("ClientCell", forIndexPath: indexPath) as! ClientDetailCell
            cell.FirstName.text = self.items[indexPath.row - 1].first_name
            cell.FirstName.font = UIFont.systemFontOfSize(f)
            
            
            cell.LastName.text = self.items[indexPath.row - 1].last_name
            cell.LastName.font = UIFont.systemFontOfSize(f)
            
            
            
            cell.Telephone.text = self.items[indexPath.row - 1].telephone
            cell.Telephone.font = UIFont.systemFontOfSize(f)
            
            
            cell.DOB.text = self.items[indexPath.row - 1].dob
            cell.DOB.font = UIFont.systemFontOfSize(f)
            
            
            return cell
        }
        
        
        
        
    }
    
     func tableView(tvClient: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        do {
            
            try CallBySelectedRow(indexPath.row)
            
        } catch {
            //print("Something went wrong!")
        }
        
        
    }
    
   
    
    
    func CallBySelectedRow(row: Int)
    {
        if(row > 0)
        {
            ClientDTO_Static.clientid = self.items[row - 1].clientid
            ShowButton()
        }
        else
        {
            ClientDTO_Static.clientid = 0
            HideButton()
        }

    }
    
    
    func GetClientList()
    {
        if(String(stringInterpolationSegment: MyKeychainWrapper.myObjectForKey("svce")) == "3")
        {
            return
        }
        
        let client = ClientRequest()
        let anyObj: AnyObject? =  client.SynchronousRequest("/getClient_record.php")
        if(anyObj != nil && anyObj is Array<AnyObject>)
        {
            for json in anyObj as! Array<AnyObject>{
                var b:ClientDetailDTO = ClientDetailDTO()
                b.first_name  = (json["first_name"] as AnyObject? as? String) ?? ""
                b.last_name = (json["last_name"] as AnyObject? as? String)! ?? ""
                b.telephone = (json["telephone"] as AnyObject? as? String)! ?? ""
                b.dob = (json["dob"] as AnyObject? as? String)! ?? ""
                let id = (json["clientid"] as AnyObject? as? String)! ?? ""
                if(id != "")
                {
                    b.clientid = Int(id)!
                }                
                b.email = (json["email"] as AnyObject? as? String)! ?? ""
                b.kin_name = (json["kin_name"] as AnyObject? as? String)! ?? ""
                b.kin_telephone = (json["kin_telephone"] as AnyObject? as? String)! ?? ""                
                items.append(b)
            }// for
        }
        StaticItems = items
    }
    
  
    
    
    @IBAction func btnEdit_TouchDown(sender: AnyObject) {
        if(ClientDTO_Static.clientid > 0)
        {
            tap.enabled = false
            backgroundThread(background: {
                self.StartAnimating()
                 self.LoadALlData()
                },
                completion: {
                    self.StopAnimating()
                    //self.performSegueWithIdentifier("GotoTreatmentNotesEdit", sender: self)
                    // A function to run in the foreground when the background thread is complete
            })
            
        }
        
    }
    
    
        
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("RevealVC") as! SWRevealViewController
//            self.presentViewController(nextViewController, animated:true, completion:nil)
   
    
//    @IBAction func btnAdd_TouchDown(sender: AnyObject) {
//        ClientDTO.client_id = 0;
//        ClientDTO.note_id = 0;
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("RevealVC") as! SWRevealViewController
//        self.presentViewController(nextViewController, animated:true, completion:nil)
//    }
    
    
    func LoadALlData()
    {
        
        LoadClientData()
        LoadQuestionsData()
        LoadAggrementData()
        LoadTherapistData()
    }
    
    func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            if(background != nil){ background!(); }
            
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
   
    
    
    @IBAction func btnDelete_TouchDown(sender: AnyObject) {
        
        if(ClientDTO_Static.clientid > 0)
        {
            tap.enabled = false
        }
        let deleteAlert = UIAlertController(title: "Delete", message: "This record will be permanently deleted?", preferredStyle: UIAlertControllerStyle.Alert)
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) in
            let Data = "&clientid=" + String(ClientDTO_Static.clientid)
            let client = ClientRequest()
            client.PostDataAsyc("/DeleteClientRecord.php", data: Data)            
            self.HideButton()
             self.Sucsess("Record deleted successfully, List will update in few seconds.")
        }))
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction) in
            
        }))
      presentViewController(deleteAlert, animated: true, completion: nil)
        
    }

    
    
    
   
    func Error(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    func Sucsess(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Success"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    
    func Search()
    {
        let strSearch: String = txtSearch.text!.lowercaseString
        
        if(strSearch == "")
        {
            items.removeAll(keepCapacity: false)
            GetClientList()
            return
        }
        let tempItems:Array<ClientDetailDTO> = StaticItems
         items.removeAll(keepCapacity: false)
        
        for obj in tempItems as Array<ClientDetailDTO>{
            if(obj.first_name.lowercaseString.rangeOfString(strSearch) != nil
                || obj.last_name.lowercaseString.rangeOfString(strSearch) != nil
                || obj.dob.lowercaseString.rangeOfString(strSearch) != nil
                || obj.telephone.lowercaseString.rangeOfString(strSearch) != nil)
            {
                items.append(obj)
            }
        }// for
    }
    
    
    func SearchAndReload()
    {
        Search()
        tvClient.reloadData()
        ClientDTO_Static.clientid = 0
        ClientDTO.client_id = 0
    }
    
    @IBAction func btnSearch_TouchDown(sender: AnyObject) {
       SearchAndReload()
    }
    @IBAction func txtSearch_EditingChanged(sender: AnyObject) {
        SearchAndReload()
    }
    
    
    
    
    
    
    func LoadClientData()
    {
        let client = ClientRequest()
        let anyObj: AnyObject? =  client.SynchronousRequest("/ClientById.php?clientid=" + String(ClientDTO_Static.clientid))
        if(anyObj != nil && anyObj is Array<AnyObject>)
        {
            for json in anyObj as! Array<AnyObject>{
                
                
                ClientDTO_Static.first_name  = (json["first_name"] as AnyObject? as? String) ?? ""
                ClientDTO_Static.last_name = (json["last_name"] as AnyObject? as? String)! ?? ""
                ClientDTO_Static.telephone = (json["telephone"] as AnyObject? as? String)! ?? ""
                ClientDTO_Static.dob = (json["dob"] as AnyObject? as? String)! ?? ""
                let id = (json["clientid"] as AnyObject? as? String)! ?? ""
                if(id != "")
                {
                    ClientDTO_Static.clientid = Int(id)!
                }
                ClientDTO_Static.email = (json["email"] as AnyObject? as? String)! ?? ""
                let hear_frm = (json["hear_frm"] as AnyObject? as? String)! ?? ""
                if(hear_frm != "")
                {
                    ClientDTO_Static.hear_frm = Int(hear_frm)!
                }
                
                let newsletter_status = (json["newsletter_status"] as AnyObject? as? String)! ?? ""
                if(newsletter_status != "")
                {
                    ClientDTO_Static.newsletter_status = toBool(newsletter_status)!
                }
                
                ClientDTO_Static.kin_name = (json["kin_name"] as AnyObject? as? String)! ?? ""
                ClientDTO_Static.kin_telephone = (json["kin_telephone"] as AnyObject? as? String)! ?? ""
                break
            }// for
        }

    }
    
    
    
    func LoadQuestionsData()
    {
        let client = ClientRequest()
        let anyObj: AnyObject? =  client.SynchronousRequest("/getQuestions_data.php?user_id=" + String(ClientDTO_Static.clientid))
        if(anyObj != nil && anyObj is Array<AnyObject>)
        {
            var i: Int = 1
            for json in anyObj as! Array<AnyObject>{
                let comment = (json["comments"] as AnyObject? as? String) ?? ""
                let yesno = toBool((json["quest_status"] as AnyObject? as? String)! ?? "")
                SetQuestionStatus(i, status: yesno!)
                SetQuestionComment(i, comment: comment)
                i += 1
                
            }// for
        }
        
    }
    
    
    func LoadAggrementData()
    {
        let client = ClientRequest()
        
        let anyObj: AnyObject? =  client.SynchronousRequest("/ClientAgreeRecord.php?clientid=" + String(ClientDTO_Static.clientid))
        if(anyObj != nil && anyObj is Array<AnyObject>)
        {
            
            for json in anyObj as! Array<AnyObject>{
                Aggrement.Date  = (json["agreement_date"] as AnyObject? as? String) ?? ""
                
                
            }
            
            if let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist") {
                if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                    let GlobalURL: String =  (dict["GlobalURL"]! as! String)
                   
                    
                   
                    if let checkedUrl = NSURL(string: GlobalURL + "/uploads/" + String(ClientDTO_Static.clientid) + ".png") {
                        do{ try downloadImage(checkedUrl) }
                        catch{
                        if(Ex.UnknownError != "")
                        {
                           Error(Ex.UnknownError)
                        }
                     }
                    }
                   
                    if let checkedUrl = NSURL(string: GlobalURL + "/uploads/therapist" + String(ClientDTO_Static.clientid) + ".png") {
                        do{ try downloadImageTherapist(checkedUrl) } catch{
                            if(Ex.UnknownError != "")
                            {
                                Error(Ex.UnknownError)
                            }
                        }
                    }
                }
                
            }
        }

    }
    
   
    
    func LoadTherapistData()
    {
        
        var TherapistRecordId = ""
        var ColorId = ""
        var SkinTypeId = ""
        var SkinType2Id = ""
        
        var Area1 = ""
        var Area2 = ""
        var Area3 = ""
        var Area4 = ""
        var Value1 = ""
        var Value2 = ""
        var Value3 = ""
        var Value4 = ""
        
        let client = ClientRequest()
        let anyObj: AnyObject? =  client.SynchronousRequest("/ClientTherapistRecord.php?clientid=" + String(ClientDTO_Static.clientid))
        if(anyObj != nil && anyObj is Array<AnyObject>)
        {
            
           
            
            for json in anyObj as! Array<AnyObject>{
                
                
                TherapistDTO_Static.comments  = (json["comments"] as AnyObject? as? String) ?? ""
                
                let id = (json["clientid"] as AnyObject? as? String)! ?? ""
                Area1 = (json["area1"] as AnyObject? as? String)! ?? ""
                Area2 = (json["area2"] as AnyObject? as? String)! ?? ""
                Area3 = (json["area3"] as AnyObject? as? String)! ?? ""
                Area4 = (json["area4"] as AnyObject? as? String)! ?? ""
                
                Value1 = (json["value1"] as AnyObject? as? String)! ?? ""
                Value2 = (json["value2"] as AnyObject? as? String)! ?? ""
                Value3 = (json["value3"] as AnyObject? as? String)! ?? ""
                Value4 = (json["value4"] as AnyObject? as? String)! ?? ""
                
                SkinTypeId = (json["skin_type1"] as AnyObject? as? String)! ?? ""
                SkinType2Id = (json["skin_type2"] as AnyObject? as? String)! ?? ""
                ColorId = (json["hair_color"] as AnyObject? as? String)! ?? ""
                let ingrow_hairs = (json["ingrow_hairs"] as AnyObject? as? String)! ?? ""
                
                if(id != "")
                {
                    
                    TherapistDTO_Static.clientid = Int(id)!
                }
                
                
                if(SkinTypeId != "")
                {
                    TherapistDTO_Static.skin_type1 = Int(SkinTypeId)!
                }
                
                if(SkinType2Id != "")
                {
                    TherapistDTO_Static.skin_type2 = Int(SkinType2Id)!
                }
                
                if(ColorId != "")
                {
                    TherapistDTO_Static.hair_color = Int(ColorId)!
                }
                
                
                if(Area1 != "")
                {
                    TherapistDTO_Static.area1 = Int(Area1)!
                }
                if(Area2 != "")
                {
                    TherapistDTO_Static.area2 = Int(Area2)!
                }
                if(Area3 != "")
                {
                    TherapistDTO_Static.area3 = Int(Area3)!
                }
                if(Area4 != "")
                {
                    TherapistDTO_Static.area4 = Int(Area4)!
                }
                
                
                if(Value1 != "")
                {
                    TherapistDTO_Static.value1 = Int(Value1)!
                }
                
                if(Value2 != "")
                {
                    TherapistDTO_Static.value2 = Int(Value2)!
                }
                
                if(Value3 != "")
                {
                    TherapistDTO_Static.value3 = Int(Value3)!
                }
                
                if(Value4 != "")
                {
                    TherapistDTO_Static.value4 = Int(Value4)!
                }
                
                if(ingrow_hairs != "")
                {
                    TherapistDTO_Static.ingrow_hairs = toBool(ingrow_hairs)!
                }
                
                break
            }// for
        }
    }
    
    
    
    
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    func downloadImage(url:NSURL){
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                var imageData = UIImagePNGRepresentation(UIImage(data: data!)!)
                Aggrement.PatientSig = imageData!.base64EncodedStringWithOptions([])
            }
        }
    }
    
    func downloadImageTherapist(url:NSURL){
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                var imageData = UIImagePNGRepresentation(UIImage(data: data!)!)
                Aggrement.TherapistSig = imageData!.base64EncodedStringWithOptions([])
            }
        }
    }
   
    
    func SetQuestionStatus(i: Int, status: Bool)
    {
        switch i {
        case 1:
           Question.S1 = status
        case 2:
            Question.S2 = status
        case 3:
           Question.S3 = status
        case 4:
           Question.S4 = status
        case 5:
            Question.S5 = status
        case 6:
            Question.S6 = status
        case 7:
           Question.S7 = status
        case 8:
           Question.S8 = status
        case 9:
            Question.S9 = status
        case 10:
           Question.S10 = status
        case 11:
           Question.S11 = status
        case 12:
            Question.S12 = status
        case 13:
            Question.S13 = status
        case 14:
            Question.S14 = status
        case 15:
            Question.S15 = status
        case 16:
            Question.S16 = status
        case 17:
            Question.S17 = status
        case 18:
            Question.S18 = status
        case 19:
            Question.S19 = status
        case 20:
            Question.S20 = status
        case 21:
            Question.S21 = status
        case 22:
            Question.S22 = status
        case 23:
            Question.S23 = status
        case 24:
            Question.S24 = status
        case 25:
           Question.S25 = status
        case 26:
            Question.S26 = status
        case 27:
           Question.S27 = status
        case 28:
            Question.S28 = status
        case 29:
            Question.S29 = status
        case 30:
            Question.S30 = status
        case 31:
            Question.S31 = status
        case 32:
           Question.S32 = status
        case 33:
            Question.S33 = status
        default:
            false
        }
        
    }
    
    func SetQuestionComment(i: Int, comment: String)
    {
        switch i {
        case 1:
            Question.Q1 = comment
        case 2:
            Question.Q2 = comment
        case 3:
            Question.Q3 = comment
        case 4:
            Question.Q4 = comment
        case 5:
            Question.Q5 = comment
        case 6:
            Question.Q6 = comment
        case 7:
            Question.Q7 = comment
        case 8:
            Question.Q8 = comment
        case 9:
            Question.Q9 = comment
        case 10:
            Question.Q10 = comment
        case 11:
            Question.Q11 = comment
        case 12:
            Question.Q12 = comment
        case 13:
            Question.Q13 = comment
        case 14:
            Question.Q14 = comment
        case 15:
            Question.Q15 = comment
        case 16:
            Question.Q16 = comment
        case 17:
            Question.Q17 = comment
        case 18:
            Question.Q18 = comment
        case 19:
            Question.Q19 = comment
        case 20:
            Question.Q20 = comment
        case 21:
            Question.Q21 = comment
        case 22:
            Question.Q22 = comment
        case 23:
            Question.Q23 = comment
        case 24:
            Question.Q24 = comment
        case 25:
            Question.Q25 = comment
        case 26:
            Question.Q26 = comment
        case 27:
            Question.Q27 = comment
        case 28:
            Question.Q28 = comment
        case 29:
            Question.Q29 = comment
        case 30:
            Question.Q30 = comment
        case 31:
            Question.Q31 = comment
        case 32:
            Question.Q32 = comment
        case 33:
            Question.Q33 = comment
        default:
            false
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
    
    
    
    
}