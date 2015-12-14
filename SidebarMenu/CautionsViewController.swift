//
//  GeneralMedicalQuestionsViewController.swift
//  SidebarMenu
//
//  Created by KBS on 14/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

class CautionsViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate
{
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var svCautions: UIScrollView!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
   
    @IBOutlet weak var swt23: UISwitch!
    @IBOutlet weak var swt24: UISwitch!
    @IBOutlet weak var swt25: UISwitch!
    @IBOutlet weak var swt26: UISwitch!
    @IBOutlet weak var swt27: UISwitch!
    @IBOutlet weak var swt28: UISwitch!
    @IBOutlet weak var swt29: UISwitch!
    @IBOutlet weak var swt30: UISwitch!
    @IBOutlet weak var swt31: UISwitch!
    @IBOutlet weak var swt32: UISwitch!
    @IBOutlet weak var swt33: UISwitch!
    
    
    @IBOutlet weak var txt23: UITextField!
    @IBOutlet weak var txt24: UITextField!
    @IBOutlet weak var txt25: UITextField!
    @IBOutlet weak var txt26: UITextField!
    @IBOutlet weak var txt27: UITextField!
    @IBOutlet weak var txt28: UITextField!
    @IBOutlet weak var txt29: UITextField!
    @IBOutlet weak var txt30: UITextField!
    @IBOutlet weak var txt31: UITextField!
    @IBOutlet weak var txt32: UITextField!
    @IBOutlet weak var txt33: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         Segue.SegueId = String(SegueId.Open_Caution)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        TapGesture()
        AssignDelegate()
       
        BindQuestions()
        
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
        txt23.delegate = self
        txt24.delegate = self
        txt25.delegate = self
        txt26.delegate = self
        txt27.delegate = self
        txt28.delegate = self
        txt29.delegate = self
        txt30.delegate = self
        txt31.delegate = self
        txt32.delegate = self
        txt33.delegate = self
    }
    func DismissKeyboard() {
        self.view.endEditing(true)
    }
    @IBAction func btnNext_TouchDown(sender: AnyObject) {
        
       
            for ( var i = 23 ; i <= 33 ; i++)
            {
                GetQuestionStatus(i)
                GetQuestionComment(i)
            }
        
            performSegueWithIdentifier("GotoAgreement", sender: nil)
            return
            //Save information on server database  
       
        
        // Make Json to save information on server
        
    }
    
//    @IBAction func btnNext_TouchDown(sender: AnyObject) {
//        StartAnimating()
//        if(ClientDTO.client_id > 0 )
//        {
//            let client = ClientRequest()
//            var QuestionData = "&jsondata=["
//            
//            for ( var i = 23 ; i <= 33 ; i++)
//            {
//                var comma = ""
//                if(i == 33)
//                {
//                    comma = ""
//                }
//                else
//                {
//                    comma = ","
//                }
//                
//                QuestionData +=  "{\"quest_id\":\"" + String(i) +
//                    "\",\"user_id\":\"" +  String(ClientDTO.client_id)
//                    + "\",\"quest_status\":\"" + GetQuestionStatus(i)
//                    + "\",\"comments\":\"" + GetQuestionComment(i) + "\"}"
//                    + comma
//            }
//            
//            QuestionData += "]"
//            
//            client.PostDataAsyc("/GeneralMedicalQuestions_Save.php", data: QuestionData)
//            StopAnimating()
//            performSegueWithIdentifier("GotoAgreement", sender: nil)
//            return
//            //Save information on server database
//            
//            
//        }
//            
//        else
//        {
//            Error("Some technical error occured, Please try again.")
//        }
//        
//        // Make Json to save information on server
//        
//    }
    
    @IBAction func btnBack_TouchDown(sender: AnyObject) {
        
       
            for ( var i = 23 ; i <= 33 ; i++)
            {
                 GetQuestionStatus(i)
                 GetQuestionComment(i)
            }
        
            return
            //Save information on server database 
        
    }
    
//    @IBAction func btnBack_TouchDown(sender: AnyObject) {
//        StartAnimating()
//        if(ClientDTO.client_id > 0 )
//        {
//            let client = ClientRequest()
//            var QuestionData = "&jsondata=["
//            
//            for ( var i = 23 ; i <= 33 ; i++)
//            {
//                var comma = ""
//                if(i == 33)
//                {
//                    comma = ""
//                }
//                else
//                {
//                    comma = ","
//                }
//                
//                QuestionData +=  "{\"quest_id\":\"" + String(i) +
//                    "\",\"user_id\":\"" +  String(ClientDTO.client_id)
//                    + "\",\"quest_status\":\"" + GetQuestionStatus(i)
//                    + "\",\"comments\":\"" + GetQuestionComment(i) + "\"}"
//                    + comma
//            }
//            
//            QuestionData += "]"
//            
//            client.PostDataAsyc("/GeneralMedicalQuestions_Save.php", data: QuestionData)
//            StopAnimating()
//            return
//            //Save information on server database
//            
//            
//        }
//    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let scrollPoint: CGPoint = CGPointMake(0, textField.frame.origin.y - 150)
        svCautions.setContentOffset(scrollPoint, animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        svCautions.setContentOffset(CGPointZero, animated: true)
    }
    
    func GetQuestionStatus(i: Int) -> String
    {
        var result = "0"
        switch i {
        case 23:
           Question.S23 = swt23.on
        case 24:
            Question.S24 = swt24.on
        case 25:
           Question.S25 = swt25.on
        case 26:
            Question.S26 = swt26.on
        case 27:
           Question.S27 = swt27.on
        case 28:
            Question.S28 = swt28.on
        case 29:
            Question.S29 = swt29.on
        case 30:
            Question.S30 = swt30.on
        case 31:
            Question.S31 = swt31.on
        case 32:
            Question.S32 = swt32.on
        case 33:
            Question.S33 = swt33.on
        default:
            result = "0"
        }
        return result
        
    }
    
    func GetQuestionComment(i: Int) -> String
    {
        var result = ""
        switch i {
        case 23:
            Question.Q23 = txt23.text!
        case 24:
            Question.Q24 = txt24.text!
        case 25:
            Question.Q25 = txt25.text!
        case 26:
            Question.Q26 = txt26.text!
        case 27:
            Question.Q27 = txt27.text!
        case 28:
            Question.Q28 = txt28.text!
        case 29:
            Question.Q29 = txt29.text!
        case 30:
            Question.Q30 = txt30.text!
        case 31:
            Question.Q31 = txt31.text!
        case 32:
            Question.Q32 = txt32.text!
        case 33:
            Question.Q33 = txt33.text!
        default:
            result = ""
        }
        return result
        
    }
    
    func Error(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    
    func BindQuestions()
    {
        for ( var i = 23 ; i <= 33 ; i++)
        {
                SetQuestionStatus(i)
                SetQuestionComment(i)
            
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
    
    
    func SetQuestionStatus(i: Int)
    {
        switch i {
        case 23:
            swt23.on = Question.S23
        case 24:
            swt24.on = Question.S24
        case 25:
            swt25.on = Question.S25
        case 26:
            swt26.on = Question.S26
        case 27:
            swt27.on = Question.S27
        case 28:
            swt28.on = Question.S28
        case 29:
            swt29.on = Question.S29
        case 30:
            swt30.on = Question.S30
        case 31:
            swt31.on = Question.S31
        case 32:
            swt32.on = Question.S32
        case 33:
            swt33.on = Question.S33
        default:
            false
        }
        
    }
    
    func SetQuestionComment(i: Int)
    {
        switch i {
        case 23:
            txt23.text = Question.Q23
        case 24:
            txt24.text = Question.Q24
        case 25:
            txt25.text = Question.Q25
        case 26:
            txt26.text = Question.Q26
        case 27:
            txt27.text = Question.Q27
        case 28:
            txt28.text = Question.Q28
        case 29:
            txt29.text = Question.Q29
        case 30:
            txt30.text = Question.Q30
        case 31:
            txt31.text = Question.Q31
        case 32:
            txt32.text = Question.Q32
        case 33:
            txt33.text = Question.Q33
        default:
            false
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