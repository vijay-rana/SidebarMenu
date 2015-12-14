
//
//  GeneralMedicalQuestionsViewController.swift
//  SidebarMenu
//
//  Created by KBS on 14/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

class TreatmentNoteDetailViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate
    
{
    var strDate = ""
    
    
   
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
   
    
    @IBOutlet weak var btnBack: UIButton!
   
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTherapist: UILabel!
    @IBOutlet weak var lblAreaTreated: UILabel!
    @IBOutlet weak var lblFluence: UILabel!
    @IBOutlet weak var lblEnergy: UILabel!
    @IBOutlet weak var lblNewMedication: UILabel!
    
    
    
    @IBOutlet weak var imgSignature: UIImageView!
    
    
    @IBOutlet weak var imgTherapist: UIImageView!
   
    @IBOutlet weak var svAgreement: UIScrollView!
    
   
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
       
        if(ClientDTO.note_id > 0)
        {
            
            BindData()
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
                self.imgSignature.image = UIImage(data: data!)
            }
        }
    }
    
    func downloadImageTherapist(url:NSURL){
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.imgTherapist.image = UIImage(data: data!)
            }
        }
    }

    
   
    
   
    func AssignDelegate()
    {
      
    }
   
    
    
    func Error(message: String)
    {
        
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
   
    
    func BindData()
    {
        let client = ClientRequest()
        let anyObj: AnyObject? =  client.SynchronousRequest("/TherapistNotesByNoteId.php?noteid=" + String(ClientDTO.note_id))
        if(anyObj != nil && anyObj is Array<AnyObject>)
        {
            
            for json in anyObj as! Array<AnyObject>{
                strDate  = (json["notes_date"] as AnyObject? as? String) ?? ""
                lblFluence.text = (json["fluence"] as AnyObject? as? String) ?? ""
                lblEnergy.text = (json["energy"] as AnyObject? as? String) ?? ""
                lblNewMedication.text = (json["new_medication"] as AnyObject? as? String) ?? ""
                lblTherapist.text = (json["therapist"] as AnyObject? as? String) ?? ""
                lblAreaTreated.text  = (json["therapist_type"] as AnyObject? as? String) ?? ""               
                
                let therapist_signImgUrl = (json["therapist_sign"] as AnyObject? as? String) ?? ""
                if(therapist_signImgUrl != "")
                {
                    if let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist") {
                        if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                            let GlobalURL: String =  (dict["GlobalURL"]! as! String)
                            imgTherapist.contentMode = UIViewContentMode.ScaleAspectFit
                            if let checkedUrl = NSURL(string: GlobalURL + "/uploads/" + therapist_signImgUrl) {
                                downloadImageTherapist(checkedUrl)
                            }
                        }
                    }
                }
                
                
                let ImgUrl = (json["client_sign"] as AnyObject? as? String) ?? ""
                if(ImgUrl != "")
                {
                    if let path = NSBundle.mainBundle().pathForResource("settings", ofType: "plist") {
                    if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                        let GlobalURL: String =  (dict["GlobalURL"]! as! String)
                        imgSignature.contentMode = UIViewContentMode.ScaleAspectFit
                        if let checkedUrl = NSURL(string: GlobalURL + "/uploads/" + ImgUrl) {
                            downloadImage(checkedUrl)
                        }
                    }
                }
                    
            }
           if(strDate != "")
            {
              lblDate.text =  strDate
            }
                break
            }
           
        }
        
    }
    
    @IBAction func btnBack_TouchDown(sender: AnyObject) { if(ClientDTO.note_id > 0)
    {
        
        performSegueWithIdentifier("GotoTreatmentNotes", sender: nil)
       
        return
    }
    else
    {
        Error("Some technical error occured, Please try again.")
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
}