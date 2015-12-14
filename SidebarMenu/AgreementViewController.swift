
//
//  GeneralMedicalQuestionsViewController.swift
//  SidebarMenu
//
//  Created by KBS on 14/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

class AgreementViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate

{
      var strDate = ""
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
  
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var viewSignature: YPDrawSignatureView!
    
    @IBOutlet weak var viewTherapistSignature: YPDrawSignatureView!
    
    
    
    @IBOutlet weak var imgSignature: UIImageView!
    
    @IBOutlet weak var imgTherapistSignature: UIImageView!
    @IBOutlet weak var svAgreement: UIScrollView!
    
    @IBOutlet weak var btnClear: UIButton!
   
    @IBOutlet weak var btnTherapistClear: UIButton!
    
    @IBOutlet weak var dtCurrent: UIDatePicker!
    
    @IBOutlet weak var lblAgreementDate: UILabel!
    
    
    @IBOutlet var btnBack: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Segue.SegueId = String(SegueId.Open_Aggrement)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        TapGesture()
        AssignDelegate()
        SetDateDefaultValue()
        BindData()
    }
    
    
    func ShowSignature()
    {
        imgSignature.hidden = false
        viewSignature.hidden = true
        
        
        imgTherapistSignature.hidden = false
        viewTherapistSignature.hidden = true
        
        btnClear.hidden = true
        btnTherapistClear.hidden = true
    }
    
    func ShowSignatureImage()
    {
        imgSignature.hidden = true
        viewSignature.hidden = false
        
        
        imgTherapistSignature.hidden = true
        viewTherapistSignature.hidden = false
        
        btnClear.hidden = false
        btnTherapistClear.hidden = false

    }
    
    
    
    func BindData()
    {
        if(Aggrement.PatientSig != "" && Aggrement.TherapistSig != "")
        {
            ShowSignature()
            let decodedData = NSData(base64EncodedString: Aggrement.PatientSig, options: NSDataBase64DecodingOptions(rawValue: 0))
            var decodedimage = UIImage(data: decodedData!)
            self.imgSignature.image = decodedimage as UIImage!
            
            
            let decodedData2 = NSData(base64EncodedString: Aggrement.TherapistSig, options: NSDataBase64DecodingOptions(rawValue: 0))
            var decodedimage2 = UIImage(data: decodedData2!)
            self.imgTherapistSignature.image = decodedimage2 as UIImage!
            
        }
        else
        {
            ShowSignatureImage()
            
            Almost_done("Please read T&C, Sign the form and pass back to therapist.")
        }
        
        if(strDate != "")
        {
            lblAgreementDate.text = "Dated: " + Aggrement.Date
            dtCurrent.hidden = true
        }
        
        
        
    }
    
    
//    func BindData()
//    {
//        let client = ClientRequest()
//        let anyObj: AnyObject? =  client.SynchronousRequest("/ClientAgreeRecord.php?clientid=" + String(ClientDTO.client_id))
//        if(anyObj != nil && anyObj is Array<AnyObject>)
//        {
//            
//            ShowSignature()
//            
//            for json in anyObj as! Array<AnyObject>{
//                 strDate  = (json["agreement_date"] as AnyObject? as? String) ?? ""
//                
//             
//            }
//            
//            if let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist") {
//                if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
//                    let GlobalURL: String =  (dict["GlobalURL"]! as! String)
//                    
//            
//            
//                            imgSignature.contentMode = UIViewContentMode.ScaleAspectFit
//                                if let checkedUrl = NSURL(string: GlobalURL + "/uploads/" + String(ClientDTO.client_id) + ".png") {
//                                        downloadImage(checkedUrl)
//                            }
//                    imgTherapistSignature.contentMode = UIViewContentMode.ScaleAspectFit
//                    if let checkedUrl = NSURL(string: GlobalURL + "/uploads/therapist" + String(ClientDTO.client_id) + ".png") {
//                        downloadImageTherapist(checkedUrl)
//                    }
//                    
//                    
//                }
//                
//            }
//        }
//        else
//        {            
//           ShowSignatureImage()
//           
//            Almost_done("Please read T&C, Sign the form and pass back to therapist.")
//        }
//       
//        if(strDate != "")
//        {
//            lblAgreementDate.text = "Dated: " + strDate
//            dtCurrent.hidden = true
//        }
//        
//       
//        
//    }
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    func downloadImage(url:NSURL){
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.imgSignature.image = UIImage(data: data!)
            }
        }
    }
    
    func downloadImageTherapist(url:NSURL){
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.imgTherapistSignature.image = UIImage(data: data!)
            }
        }
    }
    
    
    
    func SetDateDefaultValue()
    {
        
        let today = NSDate()
//        let twoDaysAgo = NSCalendar.currentCalendar().dateByAddingUnit(
//            .CalendarUnitDay,
//            value: -2,
//            toDate: today,
//            options: NSCalendarOptions(0))
        dtCurrent.date = today
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let scrollPoint: CGPoint = CGPointMake(0, textField.frame.origin.y - 150)
        svAgreement.setContentOffset(scrollPoint, animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        svAgreement.setContentOffset(CGPointZero, animated: true)
    }
    
    @IBAction func btnNext_TouchDown(sender: AnyObject) {
       
        if(viewSignature.hidden)
        {
            performSegueWithIdentifier("GotoTherapist", sender: nil)
            return
        }
       
            if(strDate == "")
            {
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                strDate = dateFormatter.stringFromDate(NSDate())
            }
            var imageData = UIImagePNGRepresentation(viewSignature.getSignature())
            var imageDataTherapist = UIImagePNGRepresentation(viewTherapistSignature.getSignature())
            
            print(imageData!.length)
            print(imageDataTherapist!.length)
            if(imageData!.length < 1200 || imageDataTherapist!.length < 1200)
            {
                Error("Both signatures are required!")
                return
            }
            
            let base64String = imageData!.base64EncodedStringWithOptions([])
            let base64StringTherapist = imageDataTherapist!.base64EncodedStringWithOptions([])
            
            
            
            Aggrement.PatientSig = base64String
            Aggrement.TherapistSig = base64StringTherapist
            Aggrement.Date = strDate
           
        
            performSegueWithIdentifier("GotoTherapist", sender: nil)
            return
       
        
    }
    
    
    @IBAction func btnBack_TouchDown(sender: AnyObject) {
        
        if(viewSignature.hidden)
        {
            return
        }
        
        if(strDate == "")
        {
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            strDate = dateFormatter.stringFromDate(NSDate())
        }
        var imageData = UIImagePNGRepresentation(viewSignature.getSignature())
        var imageDataTherapist = UIImagePNGRepresentation(viewTherapistSignature.getSignature())
        
        print(imageData!.length)
        print(imageDataTherapist!.length)
        if(imageData!.length < 1200 || imageDataTherapist!.length < 1200)
        {
            Error("Both signatures are required!")
            return
        }
        
        let base64String = imageData!.base64EncodedStringWithOptions([])
        let base64StringTherapist = imageDataTherapist!.base64EncodedStringWithOptions([])
        
        
        
        Aggrement.PatientSig = base64String
        Aggrement.TherapistSig = base64StringTherapist
        Aggrement.Date = strDate
        
        
        return
            
        
    }
    
    
    
    
    
    @IBAction func dtCurrent_ValueChanged(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        strDate = dateFormatter.stringFromDate(dtCurrent.date)
    }
    
    @IBAction func btnClear_TouchDown(sender: AnyObject) {
        viewSignature.clearSignature()
    }
    
    
    
    @IBAction func btnTherapistClear_TouchDown(sender: AnyObject) {
        viewTherapistSignature.clearSignature()
    }
    
    func Error(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    func Almost_done(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Almost done"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
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
}