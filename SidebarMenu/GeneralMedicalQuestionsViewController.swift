//
//  GeneralMedicalQuestionsViewController.swift
//  SidebarMenu
//
//  Created by KBS on 14/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation

class GeneralMedicalQuestionsViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate
{
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    @IBOutlet weak var txt5: UITextField!
    @IBOutlet weak var txt6: UITextField!
    @IBOutlet weak var txt7: UITextField!
    @IBOutlet weak var txt8: UITextField!
    @IBOutlet weak var txt9: UITextField!
    @IBOutlet weak var txt10: UITextField!
    @IBOutlet weak var svGMQ: UIScrollView!
    
    
    @IBOutlet weak var swt1: UISwitch!
    @IBOutlet weak var swt2: UISwitch!
    @IBOutlet weak var swt3: UISwitch!
    @IBOutlet weak var swt4: UISwitch!
    @IBOutlet weak var swt5: UISwitch!
    @IBOutlet weak var swt6: UISwitch!
    @IBOutlet weak var swt7: UISwitch!
    @IBOutlet weak var swt8: UISwitch!
    @IBOutlet weak var swt9: UISwitch!
    @IBOutlet weak var swt10: UISwitch!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var btnBack: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         Segue.SegueId = String(SegueId.Open_GMQ)
        
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
    func DismissKeyboard() {
        self.view.endEditing(true)
    }
    func TapGesture()
    {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    func AssignDelegate()
    {
        txt1.delegate = self
        txt2.delegate = self
        txt3.delegate = self
        txt4.delegate = self
        txt5.delegate = self
        txt6.delegate = self
        txt7.delegate = self
        txt8.delegate = self
        txt9.delegate = self
        txt10.delegate = self
    }
   
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let scrollPoint: CGPoint = CGPointMake(0, textField.frame.origin.y - 150)
        svGMQ.setContentOffset(scrollPoint, animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        svGMQ.setContentOffset(CGPointZero, animated: true)
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
       
            for ( var i = 1 ; i <= 10 ; i++)
            {
                GetQuestionStatus(i)
                GetQuestionComment(i)
            }
        
        
            performSegueWithIdentifier("GotoContraindications", sender: nil)
            return
       
        
    }
    
    
    
    func GetQuestionStatus(i: Int)
    {
        var result = "0"
        switch i {
        case 1:
           
             Question.S1  = swt1.on
        case 2:
            Question.S2  = swt2.on
        case 3:
           Question.S3  = swt3.on
        case 4:
            Question.S4  = swt4.on
        case 5:
           Question.S5  = swt5.on
        case 6:
            Question.S6  = swt6.on
        case 7:
            Question.S7  = swt7.on
        case 8:
            Question.S8  = swt8.on
        case 9:
            Question.S9  = swt9.on
        case 10:
           Question.S10  = swt10.on
        default:
            result = "0"
        }
    }
    
    func GetQuestionComment(i: Int)
    {
        var result = ""
        switch i {
        case 1:
                Question.Q1 = txt1.text!
        case 2:
                Question.Q2 = txt2.text!
        case 3:
                Question.Q3 = txt3.text!
        case 4:
                Question.Q4 = txt4.text!
        case 5:
                Question.Q5 = txt5.text!
        case 6:
                Question.Q6 = txt6.text!
        case 7:
                Question.Q7 = txt7.text!
        case 8:
                Question.Q8 = txt8.text!
        case 9:
                Question.Q9 = txt9.text!
        case 10:
                Question.Q10 = txt10.text!
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
        for ( var i = 1 ; i <= 10 ; i++)
        {
                if(i == 11)
                {
                    break
                }
                SetQuestionStatus(i)
                SetQuestionComment(i)
              
        }// for
        
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
        case 1:
           
            swt1.on = Question.S1
        case 2:
            swt2.on = Question.S2
        case 3:
            swt3.on = Question.S3
        case 4:
           swt4.on = Question.S4
        case 5:
            swt5.on = Question.S5
        case 6:
            swt6.on = Question.S6
        case 7:
            swt7.on = Question.S7
        case 8:
            swt8.on = Question.S8
        case 9:
           swt9.on = Question.S9
        case 10:
            swt10.on = Question.S10
        default:
             false
        }
        
    }
    
    func SetQuestionComment(i: Int)
    {
        switch i {
        case 1:
             txt1.text = Question.Q1
        case 2:
             txt2.text = Question.Q2
        case 3:
             txt3.text = Question.Q3
        case 4:
             txt4.text = Question.Q4
        case 5:
             txt5.text = Question.Q5
        case 6:
             txt6.text = Question.Q6
        case 7:
            txt7.text = Question.Q7
        case 8:
             txt8.text = Question.Q8
        case 9:
            txt9.text = Question.Q9
        case 10:
            txt10.text = Question.Q10
        default:
            false
        }
        
    }
    
   
    @IBAction func btnBack_TouchDown(sender: AnyObject) {
        
        if(ClientDTO.client_id > 0 )
        {
            
            for ( var i = 1 ; i <= 10 ; i++)
            {
                GetQuestionStatus(i)
                GetQuestionComment(i)
            }
            
           
            
            return
        }
        
    }
}