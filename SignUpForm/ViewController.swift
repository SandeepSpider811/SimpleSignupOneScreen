//
//  ViewController.swift
//  SignUpForm
//
//  Created by Sierra 4 on 31/01/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var txtFieldFirstName: UITextField!
    
    @IBOutlet weak var txtFieldLastName: UITextField!
    
    @IBOutlet weak var txtFieldEmail: UITextField!
    
    @IBOutlet weak var txtFieldCountryCode: UITextField!
    
    @IBOutlet weak var txtFieldMobileNo: UITextField!
    
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    @IBOutlet weak var txtFieldConfirmPassword: UITextField!
    
    @IBOutlet weak var txtFieldDOB: UITextField!
    
    @IBOutlet weak var segmentedBtnGender: UISegmentedControl!
    
    @IBOutlet weak var txtViewAboutYou: UITextView!
    
    let datePicker = UIDatePicker()
    
    var currentDate = Date()
    var currentDateString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFieldFirstName.delegate = self
        txtFieldLastName.delegate = self
        txtFieldEmail.delegate = self
        txtFieldCountryCode.delegate = self
        txtFieldMobileNo.delegate = self
        txtFieldPassword.delegate = self
        txtFieldConfirmPassword.delegate = self
        txtFieldDOB.delegate = self
        txtViewAboutYou.delegate = self
        
        createDatePicker()
        
        print(currentDate)
        
        //current date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        currentDateString = dateFormatter.string(from: currentDate)
        print(currentDateString)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == self.txtFieldFirstName {
            self.txtFieldLastName.becomeFirstResponder()
        } else if textField == self.txtFieldLastName {
            self.txtFieldEmail.becomeFirstResponder()
        } else if textField == self.txtFieldEmail {
            self.txtFieldCountryCode.becomeFirstResponder()
        } else if textField == self.txtFieldCountryCode {
            self.txtFieldMobileNo.becomeFirstResponder()
        } else if textField == self.txtFieldMobileNo {
            self.txtFieldPassword.becomeFirstResponder()
        } else if textField == self.txtFieldPassword {
            self.txtFieldConfirmPassword.becomeFirstResponder()
        } else if textField == self.txtFieldConfirmPassword {
            self.txtFieldDOB.becomeFirstResponder()
        } else if textField == self.txtFieldDOB {
            self.txtViewAboutYou.becomeFirstResponder()
        }
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func createDatePicker() {
        
        //format for picker
        datePicker.datePickerMode = .date
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        txtFieldDOB.inputAccessoryView = toolbar
        
        //assigning datePicker to textfield
        txtFieldDOB.inputView = datePicker
    }
    
    func donePressed() {
        //format date 
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        txtFieldDOB.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func btnSignUpClickAction(_ sender: Any) {
        if txtFieldFirstName.text == "" || !validateString(value: txtFieldFirstName.text!){
            
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your first name.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } else if txtFieldLastName.text == "" || !validateString(value: txtFieldLastName.text!) {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your last name.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } else if !isValidEmail(testStr: txtFieldEmail.text!) {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter correct email address",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } else if !validateCountryCode(value: txtFieldCountryCode.text!) {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter correct country code",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()

        } else if !validateMobileNo(value: txtFieldMobileNo.text!) {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter correct mobile no.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()

        } else if txtFieldPassword.text == "" {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter a password",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()

        } else if txtFieldConfirmPassword.text == "" {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please confirm your password",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()

        } else if txtFieldPassword.text != txtFieldConfirmPassword.text {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please confirm your password again",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()

        } else if txtFieldDOB.text == "" {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter DOB first",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()

        } else if txtViewAboutYou.text == "" {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please write something about yourself.",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()

        } else if txtFieldDOB.text == currentDateString {
            var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please select correct date",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        } else {
            let fullName: String = txtFieldFirstName.text! + " " + txtFieldLastName.text!
            var alert : UIAlertView = UIAlertView(title: "Congratulations", message: "\(fullName) your account has been created",
                                                  delegate: nil, cancelButtonTitle: "OK")
            alert.show()

        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func validateMobileNo(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func validateCountryCode(value: String) -> Bool {
        let COUNTRY_CODE_REGEX = "^\\d{3}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", COUNTRY_CODE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    func validateString(value: String) -> Bool {
        let STRING_REGEX = "^[a-zA-Z]+$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", STRING_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
}

