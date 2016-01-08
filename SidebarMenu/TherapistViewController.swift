
//
//  GeneralMedicalQuestionsViewController.swift
//  SidebarMenu
//
//  Created by KBS on 14/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

class TherapistViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate
{
    var TherapistObj:TherapistDTO = TherapistDTO()
    var listTherapistValues:Array<String> = []
    var listTherapistAreaRecord:Array<String> = []
    var listColors:Array<String> = []
    var listSkinTypeValues:Array<String> = []
    
    var dicLstTherapistAreaRecord = [String: String]()
    var dicLstColors = [String: String]()
    var dicLstSkinTypeValues = [String: String]()    
    
    
    
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
    
    @IBOutlet weak var imgWarning: UIImageView!
    
    @IBOutlet weak var swtIngrowingHairs: UISwitch!
    @IBOutlet weak var lblSwtichText: UILabel!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIButton!
    
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var pickerTherapistValue: UIPickerView!
    
    @IBOutlet weak var pickerArea1: UIPickerView!
    @IBOutlet weak var pickerValue1: UIPickerView!
    
    @IBOutlet weak var pickerArea2: UIPickerView!
    @IBOutlet weak var pickerValue2: UIPickerView!
    
    @IBOutlet weak var pickerArea3: UIPickerView!
    @IBOutlet weak var pickerValue3: UIPickerView!

    @IBOutlet weak var pickerArea4: UIPickerView!
    @IBOutlet weak var pickerValue4: UIPickerView!

    @IBOutlet weak var pickerSkinType: UIPickerView!
    @IBOutlet weak var pickerHairColor: UIPickerView!
    
    @IBOutlet weak var svTherapist: UIScrollView!
    @IBOutlet weak var txtComment: UITextView!
    
    @IBOutlet weak var pickerSkinType2: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Segue.SegueId = String(SegueId.Open_SkinDetail)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveClient:", name:"saveClientDetailSuccess", object: nil)
        Contradications()
        TapGesture()
        AssignDelegate()
        GetTherapistValueList()
        GetTherapistAreaRecordList()
        GetColorsList()
        ActivityIndicator()
        GetSkinTypeValuesList()
        //if(ClientDTO.client_id > 0)
        //{
            GetTherapistValue()
            BindData()
        //}
    }
    
    
    
    
    
   



func saveClient(notification: NSNotification){
    
    SaveAllData()
    
}

    func BindData()
    {
                
        
        pickerArea1.selectRow(TherapistObj.area1, inComponent: 0, animated: true)
        pickerArea2.selectRow(TherapistObj.area2, inComponent: 0, animated: true)
        pickerArea3.selectRow(TherapistObj.area3, inComponent: 0, animated: true)
        pickerArea4.selectRow(TherapistObj.area4, inComponent: 0, animated: true)
        
        if(TherapistObj.value1 > 0)
        {
            pickerValue1.selectRow(TherapistObj.value1 - 1, inComponent: 0, animated: true)
        }
        else
        {
            pickerValue1.selectRow(0, inComponent: 0, animated: true)
        }
        if(TherapistObj.value2 > 0)
        {
            pickerValue2.selectRow(TherapistObj.value2 - 1, inComponent: 0, animated: true)
        }
        else
        {
            pickerValue2.selectRow(0, inComponent: 0, animated: true)
        }
        
        if(TherapistObj.value3 > 0)
        {
            pickerValue3.selectRow(TherapistObj.value3 - 1, inComponent: 0, animated: true)
        }
        else
        {
            pickerValue3.selectRow(0, inComponent: 0, animated: true)
        }
        if(TherapistObj.value4 > 0)
        {
            pickerValue4.selectRow(TherapistObj.value4 - 1, inComponent: 0, animated: true)
        }
        else
        {
            pickerValue4.selectRow(0, inComponent: 0, animated: true)
        }
        
        
        if(TherapistObj.skin_type1 > 0)
        {
            pickerSkinType.selectRow(TherapistObj.skin_type1 - 1, inComponent: 0, animated: true)
        }
        else
        {
            pickerSkinType.selectRow(0, inComponent: 0, animated: true)
        }
        if(TherapistObj.skin_type2 > 0)
        {
            pickerSkinType2.selectRow(TherapistObj.skin_type2 - 1, inComponent: 0, animated: true)
        }
        else
        {
            pickerSkinType2.selectRow(0, inComponent: 0, animated: true)
        }
        if(TherapistObj.hair_color > 0 )
        {
            pickerHairColor.selectRow(TherapistObj.hair_color - 1, inComponent: 0, animated: true)
        }
        else
        {
            pickerHairColor.selectRow(0, inComponent: 0, animated: true)
        }
        txtComment.text = TherapistObj.comments
        swtIngrowingHairs.on = TherapistObj.ingrow_hairs
        if(TherapistObj.ingrow_hairs)
        {
            lblSwtichText.text = "Yes"
        }
        else
        {
            lblSwtichText.text = "No"
            
        }        
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
       
        
    }
    func DismissKeyboard() {
        self.view.endEditing(true)
    }
    
   
    
    @IBAction func btnNext_TouchDown(sender: AnyObject) {
       StartAnimating()
        SetStaticValues()
        SaveClientDetails()
        performSegueWithIdentifier("GotoTreatmentNotes", sender: nil)
        return
    }
    
    
    @IBAction func btnBack_TouchDown(sender: AnyObject) {        
        
        SetStaticValues()
        return
        
    }
    
    
    func SetStaticValues()
    {
        TherapistDTO_Static.ingrow_hairs = swtIngrowingHairs.on
        if(SkinTypeId != "")
        {
            TherapistDTO_Static.skin_type1 = Int(SkinTypeId)!
        }
        if(Area1 != "")
        {
            TherapistDTO_Static.area1 = Int(Area1)!
        }
        if(Value1 != "")
        {
            TherapistDTO_Static.value1 = Int(Value1)!
        }
        if(Area2 != "")
        {
            TherapistDTO_Static.area2 = Int(Area2)!
        }
        if(Value2 != "")
        {
            TherapistDTO_Static.value2 = Int(Value2)!
        }
        if(Area3 != "")
        {
            TherapistDTO_Static.area3 = Int(Area3)!
        }
        if(Value3 != "")
        {
            TherapistDTO_Static.value3 = Int(Value3)!
        }
        if(Area4 != "")
        {
            TherapistDTO_Static.area4 = Int(Area4)!
        }
        if(Value4 != "")
        {
            TherapistDTO_Static.value4 = Int(Value4)!
        }
        if(SkinType2Id != "")
        {
            TherapistDTO_Static.skin_type2 = Int(SkinType2Id)!
        }
        if(SkinTypeId != "")
        {
            TherapistDTO_Static.skin_type1 = Int(SkinTypeId)!
        }
        if(ColorId != "")
        {
            TherapistDTO_Static.hair_color = Int(ColorId)!
        }
        TherapistDTO_Static.comments = txtComment.text
    }
    
    
    @IBAction func swtIngrowingHair_ValueChanged(sender: AnyObject) {
        if swtIngrowingHairs.on {
            lblSwtichText.text = "Yes"
            
        } else {
            lblSwtichText.text = "No"            
        }
    }
    
    func Success(message: String)
    {
        
        let alert = UIAlertView()
        alert.title = "Success"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    func Error(message: String)
    {        
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    
    
    
    
    
    
    
    
    
    
    func GetTherapistValueList()
    {
        if(Collection.Static_listTherapistValues.count <= 0 )
        {
            let client = ClientRequest()
            let anyObj: AnyObject? =  client.SynchronousRequest("/TherapistValues.php")
            if(anyObj != nil && anyObj is Array<AnyObject>)
            {
                for json in anyObj as! Array<AnyObject>{
                    listTherapistValues.append((json["value_id"] as AnyObject? as? String) ?? "")
                }// for
            }
            Collection.Static_listTherapistValues = listTherapistValues
            
        }
        else
        {
            listTherapistValues = Collection.Static_listTherapistValues
        }
    }
    
    
    func GetTherapistAreaRecordList()
    {
        if(Collection.Static_listTherapistArea.count <= 0 || Collection.Static_dicLstTherapistArea.count <= 0)
        {
            let client = ClientRequest()
            let anyObj: AnyObject? =  client.SynchronousRequest("/TherapistAreaRecord.php")
            if(anyObj != nil && anyObj is Array<AnyObject>)
            {
                
                listTherapistAreaRecord.append("--Select--")
                dicLstTherapistAreaRecord["--Select--"] = "0"
                
                for json in anyObj as! Array<AnyObject>{
                    listTherapistAreaRecord.append((json["therapist_type"] as AnyObject? as? String) ?? "")
                    dicLstTherapistAreaRecord[(json["therapist_type"] as AnyObject? as? String) ?? ""] = (json["therapist_area_id"] as AnyObject? as? String) ?? ""
                }// for
            }
            Collection.Static_listTherapistArea = listTherapistAreaRecord
            Collection.Static_dicLstTherapistArea = dicLstTherapistAreaRecord
        }
        else
        {
           listTherapistAreaRecord = Collection.Static_listTherapistArea
           dicLstTherapistAreaRecord = Collection.Static_dicLstTherapistArea
        }
    }
    
    func GetColorsList()
    {
        if(Collection.Static_listColors.count <= 0 || Collection.Static_dicLstColors.count <= 0)
        {
            let client = ClientRequest()
            let anyObj: AnyObject? =  client.SynchronousRequest("/colors.php")
            if(anyObj != nil && anyObj is Array<AnyObject>)
            {
                for json in anyObj as! Array<AnyObject>{
                    listColors.append((json["color"] as AnyObject? as? String) ?? "")
                    dicLstColors[(json["color"] as AnyObject? as? String) ?? ""] = (json["color_id"] as AnyObject? as? String) ?? ""
                    
                }// for
            }
            Collection.Static_listColors = listColors
            Collection.Static_dicLstColors = dicLstColors
        }
        else
        {
           listColors = Collection.Static_listColors
           dicLstColors = Collection.Static_dicLstColors
        }
    }
    
    
    func GetSkinTypeValuesList()
    {
        if(Collection.Static_listSkinTypeValues.count <= 0 || Collection.Static_dicLstSkinTypeValues.count <= 0)
        {
            let client = ClientRequest()
            let anyObj: AnyObject? =  client.SynchronousRequest("/SkinTypeValues.php")
            if(anyObj != nil && anyObj is Array<AnyObject>)
            {
                for json in anyObj as! Array<AnyObject>{
                    listSkinTypeValues.append((json["skin_types"] as AnyObject? as? String) ?? "")
                    dicLstSkinTypeValues[(json["skin_types"] as AnyObject? as? String) ?? ""] = (json["skin_type_id"] as AnyObject? as? String) ?? ""
                }// for
            }
            Collection.Static_listSkinTypeValues  = listSkinTypeValues
            Collection.Static_dicLstSkinTypeValues = dicLstSkinTypeValues

        }
        else
        {
           listSkinTypeValues = Collection.Static_listSkinTypeValues
           dicLstSkinTypeValues = Collection.Static_dicLstSkinTypeValues
        }
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == pickerValue1 ||  pickerView == pickerValue2 ||  pickerView == pickerValue3 ||  pickerView == pickerValue4 || pickerView  == pickerSkinType)
        {
            return listTherapistValues.count
        }
        
        else if(pickerView == pickerArea1 ||  pickerView == pickerArea2 ||  pickerView == pickerArea3 ||  pickerView == pickerArea4)
        {
            return listTherapistAreaRecord.count
        }
            else if (pickerView == pickerSkinType2)
        {
            return listSkinTypeValues.count
        }
        else if (pickerView == pickerHairColor)
        {
            return listColors.count
        }
            
        else
        {
            return listTherapistValues.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerView == pickerValue1 ||  pickerView == pickerValue2 ||  pickerView == pickerValue3 ||  pickerView == pickerValue4 || pickerView  == pickerSkinType)
        {
            return listTherapistValues[row]
        }
        else if(pickerView == pickerArea1 ||  pickerView == pickerArea2 ||  pickerView == pickerArea3 ||  pickerView == pickerArea4)
        {
            return listTherapistAreaRecord[row]
        }
        else if (pickerView == pickerSkinType2)
        {
            return listSkinTypeValues[row]
        }
        else if (pickerView == pickerHairColor)
        {
            return listColors[row]
        }
        else
        {
            return listTherapistValues[row]
        }
    }
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        
        if (pickerView == pickerValue1)
        {
         let SelectText = listTherapistValues[row]
            Value1 = SelectText
        }
            
            else if (pickerView == pickerValue2)
        
        {
            let SelectText = listTherapistValues[row]
            Value2 = SelectText
        }
        
            
            else if (pickerView == pickerValue3)
        {
            let SelectText = listTherapistValues[row]
            Value3 = SelectText
        }
          
        else if (pickerView == pickerValue4)
        
        {
            let SelectText = listTherapistValues[row]
            Value4 = SelectText
        }
        
        else if (pickerView == pickerSkinType2)
        {
            let SelectText = listTherapistValues[row]
            SkinTypeId = SelectText
        }
            
        else if(pickerView == pickerArea1)
        {
            let SelectText = listTherapistAreaRecord[row]
            Area1 = dicLstTherapistAreaRecord[SelectText]!
        }
            
        else if (pickerView == pickerArea2)
        {
            let SelectText = listTherapistAreaRecord[row]
            Area2 = dicLstTherapistAreaRecord[SelectText]!
        }
        else if ( pickerView == pickerArea3)
        {
            let SelectText = listTherapistAreaRecord[row]
            Area3 = dicLstTherapistAreaRecord[SelectText]!
        }
            
        else if (pickerView == pickerArea4)
        {
            let SelectText = listTherapistAreaRecord[row]
            Area4 = dicLstTherapistAreaRecord[SelectText]!
        }
        else if (pickerView == pickerSkinType2)
        {
            let SelectText = listSkinTypeValues[row]
            SkinTypeId = dicLstSkinTypeValues[SelectText]!
        }
        else if (pickerView == pickerHairColor)
        {
            let SelectText = listColors[row]
            ColorId = dicLstColors[SelectText]!
        }
        else
        {
            false
        }
    }
    
    func textViewDidBeginEditing(textField: UITextView) {
        let scrollPoint: CGPoint = CGPointMake(0, textField.frame.origin.y - 150)
        svTherapist.setContentOffset(scrollPoint, animated: true)
    }
    
    func textViewDidEndEditing(textField: UITextView) {
        svTherapist.setContentOffset(CGPointZero, animated: true)
    }
    
    
    func GetTherapistValue()
    {
        TherapistObj.clientid = TherapistDTO_Static.clientid
        TherapistObj.skin_type1  =  TherapistDTO_Static.skin_type1
        TherapistObj.area1 =  TherapistDTO_Static.area1
        TherapistObj.value1   =  TherapistDTO_Static.value1
        TherapistObj.area2   =  TherapistDTO_Static.area2
        TherapistObj.value2   =   TherapistDTO_Static.value2
        TherapistObj.area3   =   TherapistDTO_Static.area3
        TherapistObj.value3   = TherapistDTO_Static.value3
        TherapistObj.area4   = TherapistDTO_Static.area4
        TherapistObj.value4   = TherapistDTO_Static.value4
        TherapistObj.skin_type2   = TherapistDTO_Static.skin_type2
        TherapistObj.skin_type1   = TherapistDTO_Static.skin_type1
        TherapistObj.hair_color   = TherapistDTO_Static.hair_color
        TherapistObj.comments = TherapistDTO_Static.comments        
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
    
    
    func Contradications()
    {
        let client = ClientRequest()
        let anyObj: AnyObject? =  client.SynchronousRequest("/getQuestions_data.php?user_id=" + String(ClientDTO.client_id))
        if(anyObj != nil && anyObj is Array<AnyObject>)
        {
            for json in anyObj as! Array<AnyObject>{
                let yesno: Bool = toBool((json["quest_status"] as AnyObject? as? String)! ?? "")!
                if(yesno)
                {
                    imgWarning.hidden = false
                    break
                }
                else
                {
                    imgWarning.hidden = true
                }
               
                
            }// for
        }
    }
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    func ActivityIndicator()
    {
        indicator.frame =  CGRectMake(self.view.frame.size.width/2 - 50,self.view.frame.size.height/2 - 50, 100, 100)
        indicator.layer.cornerRadius = 10.0
        indicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(indicator)
       
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
    
    
    
    func SaveAllData()
    {
        SaveQuestionsData()
        SaveAggrementData()
        SaveTherapistData()
    }
    
    
    func SaveClientDetails()
    {
        let NewslettersStatus = ClientDTO_Static.newsletter_status ? "1": "0"
        let Data1 =  "&first_name=" + ClientDTO_Static.first_name + "&last_name="
        let Data2 =   ClientDTO_Static.last_name + "&dob=" + ClientDTO_Static.dob + "&telephone=" +  ClientDTO_Static.telephone
        let Data3 = "&newsletter_status=" + NewslettersStatus + "&email="
        let Data4 =  ClientDTO_Static.email + "&kin_name=" + ""
        let Data5 = "&kin_telephone=" +  "" + "&hear_frm=" + String(ClientDTO_Static.hear_frm)
        var id = ""
        if(ClientDTO_Static.clientid > 0)
        {
            id = "&clientid=" + String(ClientDTO_Static.clientid)
        }
        let Data = Data1 +  Data2 + Data3 +  Data4 + Data5  + id
        let client = ClientRequest()
        client.PostDataAsyc("/clientDetail_save.php", data: Data)
    }
    
    
    func SaveQuestionsData()
    {
            let client = ClientRequest()
            var QuestionData = "&jsondata=["
            
            for ( var i = 1 ; i <= 33 ; i++)
            {
                var comma = ""
                if(i == 33)
                {
                    comma = ""
                }
                else
                {
                    comma = ","
                }
                
                QuestionData +=  "{\"quest_id\":\"" + String(i) +
                    "\",\"user_id\":\"" +  String(ClientDTO_Static.clientid)
                    + "\",\"quest_status\":\"" + GetQuestionStatus(i)
                    + "\",\"comments\":\"" + GetQuestionComment(i) + "\"}"
                    + comma
            }
            
            QuestionData += "]"
            client.PostDataAsyc("/GeneralMedicalQuestions_Save.php", data: QuestionData)
        
    
    }
    
    
    func SaveAggrementData()
    {
            var client = ClientRequest()
            var Data1 =  "&clientid=" +  String(ClientDTO_Static.clientid )
            var Data2 = "&imgstring=" +  Aggrement.PatientSig + "&imgstring2=" +  Aggrement.TherapistSig
            var Data3 =  "&agreement_date=" + Aggrement.Date
            var Data = Data1 + Data2 + Data3
            client.PostDataAsyc("/SaveClientAgree.php", data: Data)
                      
        
    }
    
    func SaveTherapistData()
    {
            let swtIngrowingHairsValue =  TherapistDTO_Static.ingrow_hairs ? "1": "0"
            let Data1 =  "&skin_type1=" + String(TherapistDTO_Static.skin_type1) + "&area1=" +  String(TherapistDTO_Static.area1)
                + "&value1=" + String(TherapistDTO_Static.value1) + "&area2=" +  String(TherapistDTO_Static.area2)
            let Data2  = "&value2=" + String(TherapistDTO_Static.value2) + "&area3=" +  String(TherapistDTO_Static.area3) +
                "&value3=" + String(TherapistDTO_Static.value3)
            
            let Data3 = "&area4=" +  String(TherapistDTO_Static.area4) + "&value4=" + String(TherapistDTO_Static.value4)
            
            let Data4 = "&skin_type2=" +  String(TherapistDTO_Static.skin_type2) + "&ingrow_hairs=" +  swtIngrowingHairsValue
            let Data5 = "&hair_color=" +  String(TherapistDTO_Static.hair_color) + "&comments=" + txtComment.text
            
            let id = "&clientid=" + String(ClientDTO_Static.clientid)
            
            let Data = Data1 +  Data2 + Data3 + Data4 + Data5 + id
            
        
            
            let client = ClientRequest()
            client.PostDataAsyc("/SaveTherapistEntry.php", data: Data)
       
    }
    
    
    
    
    func GetQuestionStatus(i: Int) -> String
    {
        var result = "0"
        switch i {
        case 1:
            if(Question.S1)
            {
                result = "1"
            }
        case 2:
            if(Question.S2)
            {
                result = "1"
            }
        case 3:
            if(Question.S3)
            {
                result = "1"
            }
        case 4:
            if(Question.S4)
            {
                result = "1"
            }
        case 5:
            if(Question.S5)
            {
                result = "1"
            }
        case 6:
            if(Question.S6)
            {
                result = "1"
            }
        case 7:
            if(Question.S7)
            {
                result = "1"
            }
        case 8:
            if(Question.S8)
            {
                result = "1"
            }
        case 9:
            if(Question.S9)
            {
                result = "1"
            }
        case 10:
            if(Question.S10)
            {
                result = "1"
            }
        case 11:
            if(Question.S11)
            {
                result = "1"
            }
        case 12:
            if(Question.S12)
            {
                result = "1"
            }
        case 13:
            if(Question.S13)
            {
                result = "1"
            }
        case 14:
            if(Question.S14)
            {
                result = "1"
            }
        case 15:
            if(Question.S15)
            {
                result = "1"
            }
        case 16:
            if(Question.S16)
            {
                result = "1"
            }
        case 17:
            if(Question.S17)
            {
                result = "1"
            }
        case 18:
            if(Question.S18)
            {
                result = "1"
            }
        case 19:
            if(Question.S19)
            {
                result = "1"
            }
        case 20:
            if(Question.S20)
            {
                result = "1"
            }
        case 21:
            if(Question.S21)
            {
                result = "1"
            }
        case 22:
            if(Question.S22)
            {
                result = "1"
            }
        case 23:
            if(Question.S23)
            {
                result = "1"
            }
        case 24:
            if(Question.S24)
            {
                result = "1"
            }
        case 25:
            if(Question.S25)
            {
                result = "1"
            }
        case 26:
            if(Question.S26)
            {
                result = "1"
            }
        case 27:
            if(Question.S27)
            {
                result = "1"
            }
        case 28:
            if(Question.S28)
            {
                result = "1"
            }
        case 29:
            if(Question.S29)
            {
                result = "1"
            }
        case 30:
            if(Question.S30)
            {
                result = "1"
            }
        case 31:
            if(Question.S31)
            {
                result = "1"
            }
        case 32:
            if(Question.S32)
            {
                result = "1"
            }
        case 33:
            if(Question.S33)
            {
                result = "1"
            }
        default:
            result = "0"
        }
        return result
        
    }
    
    func GetQuestionComment(i: Int) -> String
    {
        var result = ""
        switch i {
        case 1:
            result = Question.Q1
        case 2:
            result = Question.Q2
        case 3:
            result = Question.Q3
        case 4:
            result = Question.Q4
        case 5:
            result = Question.Q5
        case 6:
            result = Question.Q6
        case 7:
            result = Question.Q7
        case 8:
            result = Question.Q8
        case 9:
            result = Question.Q9
        case 10:
            result = Question.Q10
        case 11:
            result = Question.Q11
        case 12:
            result = Question.Q12
        case 13:
            result = Question.Q13
        case 14:
            result = Question.Q14
        case 15:
            result = Question.Q15
        case 16:
            result = Question.Q16
        case 17:
            result = Question.Q17
        case 18:
            result = Question.Q18
        case 19:
            result = Question.Q19
        case 20:
            result = Question.Q20
        case 21:
            result = Question.Q21
        case 22:
            result = Question.Q22
        case 23:
            result = Question.Q23
        case 24:
            result = Question.Q24
        case 25:
            result = Question.Q25
        case 26:
            result = Question.Q26
        case 27:
            result = Question.Q27
        case 28:
            result = Question.Q28
        case 29:
            result = Question.Q29
        case 30:
            result = Question.Q30
        case 31:
            result = Question.Q31
        case 32:
            result = Question.Q32
        case 33:
            result = Question.Q33
            
        default:
            result = ""
        }
        return result
        
    }
    
    
}