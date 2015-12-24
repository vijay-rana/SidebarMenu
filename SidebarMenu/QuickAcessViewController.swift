//
//  LoginViewController.swift
//  SidebarMenu
//
//  Created by KBS on 10/09/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import Foundation
import UIKit

class QuickAcessViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    @IBOutlet weak var btnSignout: UIButton!
   
    @IBOutlet weak var lblStars: UILabel!
    var Digits:String = ""
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    var list:Array<UserDTO> = []
    
    let MyKeychainWrapper = KeychainWrapper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TapGesture()
        AssignDelegate()
        ActivityIndicator()
      
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
    
    
    func Error(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Error"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    func Warning(message: String)
    {
        let alert = UIAlertView()
        alert.title = "Warning"
        alert.message = message
        alert.addButtonWithTitle("Okay")
        alert.show()
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
        //txtPassword.delegate = self
    }
    func DismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    

    
   
    @IBAction func btnSignout_TouchDown(sender: AnyObject) {
        MyKeychainWrapper.mySetObject("", forKey:kSecValueData)
        MyKeychainWrapper.writeToKeychain()
        
        MyKeychainWrapper.mySetObject("", forKey:kSecAttrAccount)
        MyKeychainWrapper.writeToKeychain()
        
        MyKeychainWrapper.mySetObject("", forKey:kSecAttrService)
        MyKeychainWrapper.writeToKeychain()
        
        ClientDTO.client_id = 0
        ClientDTO.note_id = 0
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("Login_ID") as! LoginViewController
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
  
    
    
    @IBAction func btn1_TouchDown(sender: AnyObject) {
        DigitEntered("1")
    }
    
    @IBAction func btn2_TouchDown(sender: AnyObject) {
        DigitEntered("2")
    }
    
    
    @IBAction func btn3_TouchDown(sender: AnyObject) {
        DigitEntered("3")
    }
    
    @IBAction func btn4_TouchDown(sender: AnyObject) {
        DigitEntered("4")
    }
    
    @IBAction func btn5_TouchDown(sender: AnyObject) {
        DigitEntered("5")
    }
    
    @IBAction func btn6_TouchDown(sender: AnyObject) {
        DigitEntered("6")
    }
    
    @IBAction func btn7_TouchDown(sender: AnyObject) {
        DigitEntered("7")
    }
    
    @IBAction func btn8_TouchDown(sender: AnyObject) {
        DigitEntered("8")
    }
    
    @IBAction func btn9_TouchDown(sender: AnyObject) {
        DigitEntered("9")
    }
    
    
    @IBAction func btn0_TouchDown(sender: AnyObject) {
        DigitEntered("0")
    }
    
    func DigitEntered(digit: String)
    {
        Digits = Digits + digit
        
        
        lblStars.text = ""
        
        for ( var i = 1 ; i <= Digits.characters.count ; i++)
        {
            lblStars.text = lblStars.text! + "*"
        }
        
        if(Digits.characters.count == 4)
        {
            
            if(Digits == String(stringInterpolationSegment: MyKeychainWrapper.myObjectForKey("labl")))
            {
                Segue.IsJustUnlocked = true
                performSegueWithIdentifier("GotoRevealController", sender: nil)
               return
            }
            else
            {
              Digits = ""
              lblStars.text = "Wrong key"
            }
        }
    }
    
   
}








