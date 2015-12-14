
//
//  GeneralMedicalQuestionsViewController.swift
//  SidebarMenu
//
//  Created by KBS on 14/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

class ContraindicationViewControlller: UIViewController, UITextFieldDelegate, UIScrollViewDelegate
{
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var svContraindication: UIScrollView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var swt11: UISwitch!
    @IBOutlet weak var swt12: UISwitch!
    @IBOutlet weak var swt13: UISwitch!
    @IBOutlet weak var swt14: UISwitch!
    @IBOutlet weak var swt15: UISwitch!
    @IBOutlet weak var swt16: UISwitch!
    @IBOutlet weak var swt17: UISwitch!
    @IBOutlet weak var swt18: UISwitch!
    @IBOutlet weak var swt19: UISwitch!
    @IBOutlet weak var swt20: UISwitch!
    @IBOutlet weak var swt21: UISwitch!
    @IBOutlet weak var swt22: UISwitch!
    
    
    @IBOutlet weak var txt11: UITextField!
    @IBOutlet weak var txt12: UITextField!
    @IBOutlet weak var txt13: UITextField!
    @IBOutlet weak var txt14: UITextField!
    @IBOutlet weak var txt15: UITextField!
    @IBOutlet weak var txt16: UITextField!
    @IBOutlet weak var txt17: UITextField!
    @IBOutlet weak var txt18: UITextField!
    @IBOutlet weak var txt19: UITextField!
    @IBOutlet weak var txt20: UITextField!
    @IBOutlet weak var txt21: UITextField!
    @IBOutlet weak var txt22: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Segue.SegueId = String(SegueId.Open_Contradiction)
        
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
        txt11.delegate = self
        txt12.delegate = self
        txt13.delegate = self
        txt14.delegate = self
        txt15.delegate = self
        txt16.delegate = self
        txt17.delegate = self
        txt18.delegate = self
        txt19.delegate = self
        txt20.delegate = self
        txt21.delegate = self
        txt22.delegate = self
    }
    
    
    func DismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let scrollPoint: CGPoint = CGPointMake(0, textField.frame.origin.y - 150)
        svContraindication.setContentOffset(scrollPoint, animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        svContraindication.setContentOffset(CGPointZero, animated: true)
    }
    
    @IBAction func btnNext_TouchDown(sender: AnyObject) {
        
       
            for ( var i = 11 ; i <= 22 ; i++)
            {
                GetQuestionStatus(i)
                GetQuestionComment(i)
            }
           
        
            performSegueWithIdentifier("GotoCautions", sender: nil)
            return
            
       
        
        // Make Json to save information on server
        
    }
    
    
    @IBAction func btnBack_TouchDown(sender: AnyObject) {
        
       
            for ( var i = 11 ; i <= 22 ; i++)
            {
                GetQuestionStatus(i)
                GetQuestionComment(i)
            }
        
            return
        
    }
    
    
    
    
    func GetQuestionStatus(i: Int) -> String
    {
        var result = "0"
        switch i {
        case 11:
            Question.S11 = swt11.on
        case 12:
            Question.S12 = swt12.on
        case 13:
            Question.S13 = swt13.on
        case 14:
           Question.S14 = swt14.on
        case 15:
            Question.S15 = swt15.on
        case 16:
           Question.S16 = swt16.on
        case 17:
            Question.S17 = swt17.on
        case 18:
           Question.S18 = swt18.on
        case 19:
            Question.S19 = swt19.on
        case 20:
           Question.S20 = swt20.on
        case 21:
            Question.S21 = swt21.on
        case 22:
            Question.S22 = swt22.on
        default:
            result = "0"
        }
        return result
        
    }
    
    func GetQuestionComment(i: Int)
    {
        var result = ""
        switch i {
        case 11:
            Question.Q11 = txt11.text!
        case 12:
            Question.Q12 = txt12.text!
        case 13:
            Question.Q13 = txt13.text!
        case 14:
            Question.Q14 = txt14.text!
        case 15:
            Question.Q15 = txt15.text!
        case 16:
            Question.Q16 = txt16.text!
        case 17:
            Question.Q17 = txt17.text!
        case 18:
            Question.Q18 = txt18.text!
        case 19:
            Question.Q19 = txt19.text!
        case 20:
            Question.Q20 = txt20.text!
        case 21:
            Question.Q21 = txt21.text!
        case 22:
            Question.Q22 = txt22.text!
        default:
            result = ""
        }
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
        for ( var i = 11 ; i <= 22 ; i++)
        {
                SetQuestionStatus(i)
                SetQuestionComment(i)
        }
    }
    
//    func BindQuestions()
//    {
//        let client = ClientRequest()
//        let anyObj: AnyObject? =  client.SynchronousRequest("/getQuestions_data.php?user_id=" + String(ClientDTO.client_id))
//        if(anyObj != nil && anyObj is Array<AnyObject>)
//        {
//            var i: Int = 1
//            for json in anyObj as! Array<AnyObject>{
//                if(i < 10)
//                {
//                    i += 1
//                    continue
//                }
//                else if(i == 23)
//                {
//                    break
//                }
//                let comment = (json["comments"] as AnyObject? as? String) ?? ""
//                let yesno = toBool((json["quest_status"] as AnyObject? as? String)! ?? "")
//                SetQuestionStatus(i, status: yesno!)
//                SetQuestionComment(i, comment: comment)
//                i += 1
//                
//            }// for
//        }
//    }
    
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
        case 11:
            swt11.on = Question.S11
        case 12:
            swt12.on = Question.S12
        case 13:
            swt13.on = Question.S13
        case 14:
            swt14.on = Question.S14
        case 15:
            swt15.on = Question.S15
        case 16:
            swt16.on = Question.S16
        case 17:
            swt17.on = Question.S17
        case 18:
            swt18.on = Question.S18
        case 19:
            swt19.on = Question.S19
        case 20:
            swt20.on = Question.S20
        case 21:
            swt21.on = Question.S21
        case 22:
            swt22.on = Question.S22
        default:
            false
        }
        
    }
    
    func SetQuestionComment(i: Int)
    {
        switch i {
        case 11:
            txt11.text = Question.Q11
        case 12:
            txt12.text = Question.Q12
        case 13:
            txt13.text = Question.Q13
        case 14:
            txt14.text = Question.Q14
        case 15:
            txt15.text = Question.Q15
        case 16:
            txt16.text = Question.Q16
        case 17:
            txt17.text = Question.Q17
        case 18:
            txt18.text = Question.Q18
        case 19:
            txt19.text = Question.Q19
        case 20:
            txt20.text = Question.Q20
        case 21:
            txt21.text = Question.Q21
        case 22:
            txt22.text = Question.Q22
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
