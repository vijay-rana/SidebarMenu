
//
//  GeneralMedicalQuestionsViewController.swift
//  SidebarMenu
//
//  Created by KBS on 14/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

class TreatmentNotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate
    
{
    let MyKeychainWrapper = KeychainWrapper()
    var strDate = ""
    var items:Array<TreatmentNotesDTO> = []
    
    var listTherapistArea:Array<String> = []
    var listTherapist:Array<String> = []
   
    var listFluency:Array<String> = []
    var listEnergy:Array<String> = []
    
    var dicLstTherapistArea = [String: String]()
    var dicLstTherapist = [String: String]()
    
    
    
    var dicLstTherapistSig = [Int: String]()
    var dicLstPatientSign = [Int: String]()
    
    
   
    var txtFluence = ""
    var txtEnergy = ""
    
    
    var TherapistAreaId = ""
    var TherapistId = ""
    
    
    var IsBold: Bool = false
    
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var viewSignature: YPDrawSignatureView!
    
    @IBOutlet weak var therapistSignature: YPDrawSignatureView!
    
    @IBOutlet weak var btnClearTherapist: UIButton!
    @IBOutlet weak var imgSignature: UIImageView!
    
    
    @IBOutlet var imgTherapistSignature: UIImageView!
    
    @IBOutlet weak var svAgreement: UIScrollView!
    
    @IBOutlet weak var btnClear: UIButton!
    
    
    @IBOutlet weak var dtCurrent: UIDatePicker!
    
    @IBOutlet weak var pickerTherapist: UIPickerView!
    
    @IBOutlet weak var pickerFluency: UIPickerView!
    @IBOutlet weak var pickerTherapistArea: UIPickerView!
    @IBOutlet weak var pickerEnergy: UIPickerView!
    
    
    @IBOutlet weak var txtNewMedication: UITextField!
   
    
    @IBOutlet weak var tvTreatmentNotes: UITableView!
    
    @IBOutlet weak var btnAdd: UIButton!
    
    
    
    @IBOutlet var btnUploadAll: UIButton!
    
    @IBOutlet var lblNotesAddedCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Segue.SegueId = String(SegueId.GotoTreatmentNotesEdit)
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        ClientDTO.note_id = 0
        btnView.hidden = true
        HideButton()
        ShowView()
        TapGesture()
        AssignDelegate()
        GetTherapistAreaList()
        GetTherapistList()
        GetTreatmentNotesList()
        SetDateDefaultValue()
        CreateFluencyList()
        CreateEnergyList()
        
        CreateSignList()
        
        if(ClientDTO_Static.clientid > 0)
        {
            
            BindData()
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshTreatmentNotesList:", name:"refreshTreatmentNotesTableView", object: nil)
        
    }
    
    
    func refreshTreatmentNotesList(notification: NSNotification){
        ClientDTO.note_id = 0
        items.removeAll(keepCapacity: false)
        GetTreatmentNotesList()
        CreateSignList()
        tvTreatmentNotes.reloadData()
    }
    
    
    func BindData()
    {
        
        
        
    }
    
//    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
//        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
//            completion(data: data)
//            }.resume()
//    }
    
//    func downloadImage(url:NSURL){
//        getDataFromUrl(url) { data in
//            dispatch_async(dispatch_get_main_queue()) {
//                self.imgSignature.image = UIImage(data: data!)
//            }
//        }
//    }
    
    
   
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func TapGesture()
    {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func AssignDelegate()
    {
        txtNewMedication.delegate = self
        tvTreatmentNotes.delegate = self
        tvTreatmentNotes.dataSource = self
    }
    
    func DismissKeyboard() {
        self.view.endEditing(true)       
        HideButton()
        ShowView()
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == pickerTherapist)
        {
            return listTherapist.count
        }            
       
        else if (pickerView == pickerTherapistArea)
        {
            return listTherapistArea.count
        }
        else if (pickerView == pickerFluency)
        {
            return listFluency.count
        }
        else if (pickerView == pickerEnergy)
        {
            return listEnergy.count
        }
            
        else
        {
            return listTherapist.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerView == pickerTherapist)
        {
            return listTherapist[row]
        }
        else if (pickerView == pickerTherapistArea)
        {
            return listTherapistArea[row]
        }
        else if (pickerView == pickerFluency)
        {
            return listFluency[row]
        }
        else if (pickerView == pickerEnergy)
        {
            return listEnergy[row]
        }
        else
        {
            return listTherapist[row]
        }
    }
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        
        if(pickerView == pickerTherapist)
        {
            let SelectText = listTherapist[row]
            TherapistId = dicLstTherapist[SelectText]!
        }
            
        else if (pickerView == pickerTherapistArea)
        {
            let SelectText = listTherapistArea[row]
            TherapistAreaId = dicLstTherapistArea[SelectText]!
        }
        else if (pickerView == pickerFluency)
        {
            txtFluence = listFluency[row]
        }
        else if (pickerView == pickerEnergy)
        {
            txtEnergy = listEnergy[row]
        }
        else
        {
            false
        }
    }
    
    
    func GetTherapistAreaList()
    {
        if(Collection.Static_listTherapistArea.count <= 0 && Collection.Static_dicLstTherapistArea.count <= 0)
        {
            let client = ClientRequest()
            let anyObj: AnyObject? =  client.SynchronousRequest("/TherapistAreaRecord.php")
            if(anyObj != nil && anyObj is Array<AnyObject>)
            {
                listTherapistArea.append("--Select--")
                dicLstTherapistArea["--Select--"] = "0"
                for json in anyObj as! Array<AnyObject>{
                    listTherapistArea.append((json["therapist_type"] as AnyObject? as? String) ?? "")
                    dicLstTherapistArea[(json["therapist_type"] as AnyObject? as? String) ?? ""] = (json["therapist_area_id"] as AnyObject? as? String) ?? ""
                }// for
                
              
            }
            Collection.Static_listTherapistArea = listTherapistArea
            Collection.Static_dicLstTherapistArea = dicLstTherapistArea
        }
        else
        {
           listTherapistArea = Collection.Static_listTherapistArea
            dicLstTherapistArea = Collection.Static_dicLstTherapistArea
        }
    }
    
    func GetTherapistList()
    {
        if(Collection.Static_dicLstTherapist.count <= 0  &&  Collection.Static_listTherapist.count <= 0)
        {
            let client = ClientRequest()
            let anyObj: AnyObject? =  client.SynchronousRequest("/Therapist.php")
            if(anyObj != nil && anyObj is Array<AnyObject>)
            {
                listTherapist.append("--")
                dicLstTherapist["--"] = "0"
                for json in anyObj as! Array<AnyObject>{
                    listTherapist.append((json["therapist"] as AnyObject? as? String) ?? "")
                    dicLstTherapist[(json["therapist"] as AnyObject? as? String) ?? ""] = (json["therapist_id"] as AnyObject? as? String) ?? ""
                    
                }// for
            }
            Collection.Static_dicLstTherapist = dicLstTherapist
            Collection.Static_listTherapist = listTherapist
        }
        else
        {
          dicLstTherapist =   Collection.Static_dicLstTherapist
          listTherapist =  Collection.Static_listTherapist
        }
    }
    
    
    func CreateFluencyList()
    {
        
        for var i = 1; i <= 100; ++i {
            listFluency.append(String(i))

        }
        
       
    }
    
    func CreateEnergyList()
    {
        for var i = 1; i <= 100; ++i {
        listEnergy.append(String(i))
        
        }
    }
    
    
    
    
    
    var window: UIWindow?
    func GotoMainScreen()
    {
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewControllerWithIdentifier("Login_ID") as! LoginViewController
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = initialViewControlleripad
        self.window?.makeKeyAndVisible()
        
    }
    
    
  
    
    func tableView(tvTreatmentNotes: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count + 1;
    }
    
    func tableView(tvTreatmentNotes: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0)
        {
            let cell = tvTreatmentNotes.dequeueReusableCellWithIdentifier("TherapistCell", forIndexPath: indexPath) as! TherapistCell
           
            cell.lblDate.font = UIFont.boldSystemFontOfSize(22.0)
            cell.lblDate.text = "Date"
            
            
            cell.lblTherapist.font = UIFont.boldSystemFontOfSize(22.0)
            cell.lblTherapist.text = "Therapist"
            
            cell.lblFE.font = UIFont.boldSystemFontOfSize(22.0)
            cell.lblFE.text = "F / E"
            
            cell.lblAreaTreated.font = UIFont.boldSystemFontOfSize(22.0)
            cell.lblAreaTreated.text =  "Area Treated"
            
            return cell
        }
        else
        {
             let f: CGFloat = 17.0
            let cell = tvTreatmentNotes.dequeueReusableCellWithIdentifier("TherapistCell", forIndexPath: indexPath) as! TherapistCell
                cell.lblDate.text = self.items[indexPath.row - 1].notes_date
                cell.lblDate.font = UIFont.systemFontOfSize(f)
            
            if(self.items[indexPath.row - 1].fluence.isEmpty && self.items[indexPath.row - 1].energy.isEmpty)
            {
                cell.lblFE.text = "--"
                
            }
            else
            {
            cell.lblFE.text = self.items[indexPath.row - 1].fluence + " / " + self.items[indexPath.row - 1].energy
               
            }
            
            
            cell.lblFE.font = UIFont.systemFontOfSize(f)
            if(self.items[indexPath.row - 1].therapist_id > 0 )
                {
                   
                    
                    if(listTherapist.count > self.items[indexPath.row - 1].therapist_id)
                    {
                        cell.lblTherapist.text = listTherapist[self.items[indexPath.row - 1].therapist_id]
                    }
                }
            cell.lblTherapist.font = UIFont.systemFontOfSize(f)
                if(self.items[indexPath.row - 1].area_treated_id > 0 )
                {
                    cell.lblAreaTreated.text = listTherapistArea[self.items[indexPath.row - 1].area_treated_id]
                   
                }
            
            cell.lblAreaTreated.font =  UIFont.systemFontOfSize(f)
                return cell
        }
    }
    
    func tableView(tvTreatmentNotes: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        do {
            let encrypted = try BindBySelectedRow(indexPath.row)
            
        } catch {
            print("Something went wrong!")
        }
        
        
    }
    
    
    func BindBySelectedRow(row: Int)
    {
        if(row > 0 && items.count >= row)
        {
                ClientDTO.note_id =  self.items[row - 1].note_id
                  pickerTherapist.selectRow(self.items[row - 1].therapist_id, inComponent: 0, animated: true)
                   pickerTherapistArea.selectRow(self.items[row - 1].area_treated_id, inComponent: 0, animated: true)
                  pickerFluency.selectRow(Int(self.items[row - 1].fluence)! - 1, inComponent: 0, animated: true)
                   pickerEnergy.selectRow(Int(self.items[row - 1].energy )! - 1, inComponent: 0, animated: true)
                
                txtNewMedication.text =  self.items[row - 1].new_medication
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let convertedStartDate =  dateFormatter.dateFromString(self.items[row - 1].notes_date)
                dtCurrent.date = convertedStartDate!
                
                
                strDate = self.items[row - 1].notes_date
                
                
                txtFluence = self.items[row - 1].fluence
                txtEnergy = self.items[row - 1].energy
                
                
            
                TherapistAreaId = String(self.items[row - 1].area_treated_id)
                
                TherapistId = String(self.items[row - 1].therapist_id)
                
                
                viewSignature.hidden = true
                therapistSignature.hidden = true
                
                HideView()
                ShowSig()
                
                ShowButton()
         }
        else
        {
            viewSignature.hidden = false
            therapistSignature.hidden = false
            
            ClientDTO.note_id = 0
            HideButton()
            ShowView()
            
            Reset()
            
        }

    }
    
    
   func  ShowView()
    {
    viewSignature.hidden = false
    therapistSignature.hidden = false

   
    }
    
   func HideView()
    {
    viewSignature.hidden = true
    therapistSignature.hidden = true
    }
    
    
    func ShowSig()
    {
        if(dicLstPatientSign[ClientDTO.note_id] != nil)
        {
        
        let decodedData = NSData(base64EncodedString: dicLstPatientSign[ClientDTO.note_id]!, options: NSDataBase64DecodingOptions(rawValue: 0))
       var decodedimage = UIImage(data: decodedData!)
       self.imgSignature.image = decodedimage as UIImage!
            
            btnView.hidden = true
        }
        
        else
        {
            ShowView()
            btnView.hidden = false
        }
        
        if(dicLstTherapistSig[ClientDTO.note_id] != nil)
        {
       let decodedData2 = NSData(base64EncodedString: dicLstTherapistSig[ClientDTO.note_id]!, options: NSDataBase64DecodingOptions(rawValue: 0))
        var decodedimage2 = UIImage(data: decodedData2!)
        self.imgTherapistSignature.image = decodedimage2 as UIImage!
            
            btnView.hidden = true
            
        }
        else
        {
            ShowView()
             btnView.hidden = false
        }
       
    }
    
    
    func GetTreatmentNotesList()
    {
        let client = ClientRequest()
        let anyObj: AnyObject? =  client.SynchronousRequest("/ClientTherapistNotes.php?clientid=" + String(ClientDTO_Static.clientid))
        if(anyObj != nil && anyObj is Array<AnyObject>)
        {
            for json in anyObj as! Array<AnyObject>{
                var b:TreatmentNotesDTO = TreatmentNotesDTO()
                //b.imgstring  = (json["imgstring"] as AnyObject? as? String) ?? ""
                b.notes_date = (json["notes_date"] as AnyObject? as? String)! ?? ""
                b.fluence = (json["fluence"] as AnyObject? as? String)! ?? ""
                b.energy = (json["energy"] as AnyObject? as? String)! ?? ""
                b.new_medication = (json["new_medication"] as AnyObject? as? String)! ?? ""
                b.client_sign = (json["client_sign"] as AnyObject? as? String)! ?? ""
                b.therapist_sign = (json["therapist_sign"] as AnyObject? as? String)! ?? ""
                let therapist_id = (json["therapist_id"] as AnyObject? as? String)! ?? ""
                let area_treated_id = (json["area_treated_id"] as AnyObject? as? String)! ?? ""
                let note_id = (json["note_id"] as AnyObject? as? String)! ?? ""
                if(therapist_id != "")
                {
                    b.therapist_id = Int(therapist_id)!
                }
                if(area_treated_id != "")
                {
                    b.area_treated_id = Int(area_treated_id)!
                }
                if(note_id != "")
                {
                    b.note_id = Int(note_id)!
                }
                
                items.append(b)
            }// for
        }
    }
    
    
    
    @IBAction func btnClear_TouchDown(sender: AnyObject) {
        viewSignature.clearSignature()
    }
    
    
    @IBAction func btnClearTherapist_TouchDown(sender: AnyObject) {
        therapistSignature.clearSignature()
        
    }
    
    
    @IBAction func btnUploadAll_TouchDown(sender: AnyObject) {
       UploadAllNotes()
    }
    
    
    
    @IBAction func dtCurrent_ValueChanged(sender: AnyObject) {
        
    }
    
    
    @IBAction func btnSave_TouchDown(sender: AnyObject) {
        //Reset()
        GotoMainScreen()
        
        
    }
    
    @IBAction func btnView_TouchDown(sender: AnyObject) {
        
        if(ClientDTO.note_id > 0)
        {
            AddUpdateNotes(String(ClientDTO.note_id))
       
        }
        else
        {
            Error("Some technical error occured, Please try again.")
        }
       
    }
    
    @IBAction func btnDelete_TouchDown(sender: AnyObject) {
       
        let deleteAlert = UIAlertController(title: "Delete", message: "This record will be permanently deleted?", preferredStyle: UIAlertControllerStyle.Alert)
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction) in
            let Data = "&noteid=" + String(ClientDTO.note_id)
            let client = ClientRequest()
            client.PostDataAsyc("/DeleteTherapistNotes.php", data: Data)
            self.HideButton()
            self.Success("Record deleted successfully, List will update in few seconds.")
        }))
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction) in
            
        }))
        presentViewController(deleteAlert, animated: true, completion: nil)
        
        
    }
    
    func HideButton()
    {
       
        btnDelete.hidden = true
        
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
        
    }
    
    
    func SetDateDefaultValue()
    {
        
//        let today = NSDate()
//        let twoDaysAgo = NSCalendar.currentCalendar().dateByAddingUnit(
//            .CalendarUnitDay,
//            value: -2,
//            toDate: today,
//            options: NSCalendarOptions(0))
        dtCurrent.date = NSDate()
    }
    @IBAction func btnAdd_TouchDown(sender: AnyObject) {
        
        do  { try AddNewNotesToList() } catch{
            
            if(Ex.UnknownError != "")
            {
                Error(Ex.UnknownError)
            }
        }
    }
    
    
   
    
    func AddNewNotesToList()  throws
    {
        var obj: TreatmentNotesDTO = TreatmentNotesDTO()
        
        if(Collection.Static_listTreatmentNotesDTO.count >= 5)
        {
            Error("Maximum five notes can be added!")
            return
        }
        
        if(ClientDTO_Static.clientid > 0 )
        {
            if(strDate == "")
            {
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                strDate = dateFormatter.stringFromDate(NSDate())
            }
            
            var imageData = UIImagePNGRepresentation(viewSignature.getSignature())
            
            var therapistImageData = UIImagePNGRepresentation(therapistSignature.getSignature())
            
            print(TherapistAreaId)
            
            var base64String = imageData!.base64EncodedStringWithOptions([])
            var TherapistBase64String = therapistImageData!.base64EncodedStringWithOptions([])
            
            
            if(imageData!.length < 1200)
            {
                base64String = ""
            }
            
            if(therapistImageData!.length < 1200)
            {
                TherapistBase64String = ""
            }
            
            if(NumberOnly(TherapistAreaId)  <= 0 || NumberOnly(TherapistId) <= 0 || txtEnergy == "" || txtFluence == "")
            {
                Error("Fileds with (*) are required!")
                return
            }
            
//            guard let therapistID = Int(TherapistId) else {
//                Error("Therapist is required!")
//                return
//            }
            
            obj.clientid = ClientDTO_Static.clientid
            obj.imgstring = base64String
            obj.therapist_sign = TherapistBase64String
            obj.notes_date = strDate
            obj.fluence = txtFluence
            obj.energy = txtEnergy
            obj.new_medication = txtNewMedication.text!
            
            
            obj.therapist_id  = Int(TherapistId)!
            
            
            
            
            obj.area_treated_id = Int(TherapistAreaId)!
            
            
            Collection.Static_listTreatmentNotesDTO.append(obj)
            
            
            lblNotesAddedCount.text = String(Collection.Static_listTreatmentNotesDTO.count)
            
            Success("Note added successfully")
            
            
            Reset()
            
            
            
        }
        else
        {
            Error("Some technical error occured, Please try again.")
        }
        
        return
        
    }
    
    
    func UploadAllNotes()
    {
        if(ClientDTO_Static.clientid > 0 )
        {
            if(Collection.Static_listTreatmentNotesDTO.count < 1)
            {
                Error("Collection list of notes are empty!")
                return
            }
            
            var imageData = UIImagePNGRepresentation(viewSignature.getSignature())
            var therapistImageData = UIImagePNGRepresentation(therapistSignature.getSignature())
            
            
            var base64String = imageData!.base64EncodedStringWithOptions([])
            var TherapistBase64String = therapistImageData!.base64EncodedStringWithOptions([])
            
            
            if(imageData!.length < 1200 || therapistImageData!.length < 1200)
            {
                Error("Both signature are required!")
                return
            }
           
            
            for obj in Collection.Static_listTreatmentNotesDTO
            {
                var client = ClientRequest()
                var Data1 =  "&clientid=" +  String(ClientDTO_Static.clientid)
                var Data2 = "&imgstring=" +  base64String + "&imgstring2=" +  TherapistBase64String
                var Data3 =  "&notes_date=" + obj.notes_date + "&fluence=" + obj.fluence + "&energy=" + obj.energy
                var Data4 = "&new_medication=" + obj.new_medication + "&therapist_id=" + String(obj.therapist_id)
                    + "&area_treated_id=" + String(obj.area_treated_id)
                var Data = Data1 + Data2 + Data3 + Data4
                client.PostDataAsyc("/SaveTherapistNotes.php", data: Data)

            }
            
            Success("Note added successfully. Your list will be update in few seconds.")
            
            Reset()
            Collection.Static_listTreatmentNotesDTO.removeAll()
            lblNotesAddedCount.text = String(Collection.Static_listTreatmentNotesDTO.count)
            
            return
        }
        else
        {
            Error("Some technical error occured, Please try again.")
        }
    }
    
    
    func AddUpdateNotes(noteid: String)
    {
        if(ClientDTO_Static.clientid > 0 )
        {
            if(strDate == "")
            {
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                strDate = dateFormatter.stringFromDate(NSDate())
            }
            
            var imageData = UIImagePNGRepresentation(viewSignature.getSignature())
            
            var therapistImageData = UIImagePNGRepresentation(therapistSignature.getSignature())
            
            
           
            
            
            var base64String = imageData!.base64EncodedStringWithOptions([])
            var TherapistBase64String = therapistImageData!.base64EncodedStringWithOptions([])
            
            
            if(imageData!.length < 1200)
            {
                base64String = ""
            }
            
            if(therapistImageData!.length < 1200)
            {
                TherapistBase64String = ""
            }
            
            if(NumberOnly(TherapistAreaId)  <= 0 )
            {
                Error("Fileds with (*) are required!")
                return
            }
            
            var client = ClientRequest()
            var Data1 =  "&clientid=" +  String(ClientDTO_Static.clientid)
            var Data2 = "&imgstring=" +  base64String + "&imgstring2=" +  TherapistBase64String
            var Data3 =  "&notes_date=" + strDate + "&fluence=" + txtFluence + "&energy=" + txtEnergy
            var Data4 = "&new_medication=" + txtNewMedication.text! + "&therapist_id=" + TherapistId
                + "&area_treated_id=" + TherapistAreaId + "&noteid=" + noteid
            
            var Data = Data1 + Data2 + Data3 + Data4
            
            
            client.PostDataAsyc("/SaveTherapistNotes.php", data: Data)
            
            Success("Note added successfully. Your list will be update in few seconds.")
            
            
            Reset()
            
            
            return
        }
        else
        {
            Error("Some technical error occured, Please try again.")
        }
    }

    
    
    func NumberOnly(TherapistAreaId: String) -> Int
    {
        if(Int(String(TherapistAreaId)) == nil)
        {
           return 0
        }
        if( Int(String(TherapistAreaId)) > 0)
        {
            return Int(String(TherapistAreaId))!
        }
        else
        {
            return 0
        }
       
    }
    
    
    
    func Reset()
    {
        txtNewMedication.text = ""
        txtFluence = "1"
        txtEnergy = "1"
        TherapistAreaId = ""
        TherapistId = ""
        pickerEnergy.selectRow(0, inComponent: 0, animated: true)
        pickerFluency.selectRow(0, inComponent: 0, animated: true)
        pickerTherapist.selectRow(0, inComponent: 0, animated: true)
        pickerTherapistArea.selectRow(0, inComponent: 0, animated: true)
        therapistSignature.clearSignature()
        viewSignature.clearSignature()
        ClientDTO.note_id = 0
        
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
    
    
    func CreateSignList()
    {        
        if let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                let GlobalURL: String =  (dict["GlobalURL"]! as! String)
               
                for notes in items{
                    if(notes.therapist_sign != "")
                    {
                        if let checkedUrl = NSURL(string: GlobalURL + "/uploads/" + notes.therapist_sign) {
                            downloadImageTherapist(checkedUrl, noteid:notes.note_id)
                        }
                    }
                    if(notes.client_sign != "")
                    {
                        if let checkedUrl = NSURL(string: GlobalURL + "/uploads/" + notes.client_sign) {
                            downloadImage(checkedUrl, noteid:notes.note_id)
                        }
                    }
                }
           
            }
        }
    }
    
    
    
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    func downloadImage(url:NSURL, noteid: Int){
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
               var imageData = UIImagePNGRepresentation(UIImage(data: data!)!)
                
               self.dicLstPatientSign[noteid] = imageData!.base64EncodedStringWithOptions([])
                          }
        }
    }
    
    func downloadImageTherapist(url:NSURL, noteid: Int){
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
               var imageData = UIImagePNGRepresentation(UIImage(data: data!)!)
                
                
               self.dicLstTherapistSig[noteid] = imageData!.base64EncodedStringWithOptions([])
               
            }
        }
    }
    
    
}