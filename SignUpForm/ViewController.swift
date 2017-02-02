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
    
    //current date changed to string
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == UIReturnKeyType.default {
            textField.returnKeyType = UIReturnKeyType.next
        }
        
        //Next button added to numeric keyboard
        let toolbarNextButtonOnNumPad = UIToolbar()
        let nextButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbarNextButtonOnNumPad.setItems([nextButton], animated: false)
        
        txtFieldCountryCode.inputAccessoryView = toolbarNextButtonOnNumPad
        txtFieldMobileNo.inputAccessoryView = toolbarNextButtonOnNumPad
        
        /*if textField == txtFieldCountryCode {
            let toolbarNextButtonOnNumPad = UIToolbar()
            let nextButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(numpadDonePressed(_: )))
            toolbarNextButtonOnNumPad.setItems([nextButton], animated: false)
            
            txtFieldCountryCode.inputAccessoryView = toolbarNextButtonOnNumPad
        }*/
        return true
    }
    
    /*func numpadDonePressed(_ txtField: UITextField){
        if txtField == txtFieldCountryCode {
            self.txtFieldMobileNo.becomeFirstResponder()
        } else if txtField == txtFieldMobileNo {
            self.txtFieldPassword.becomeFirstResponder()
        }
    }*/
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
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
            let alert = UIAlertController(title: "Oops!", message: "Please enter your first name.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)
        } else if txtFieldLastName.text == "" || !validateString(value: txtFieldLastName.text!) {
            let alert = UIAlertController(title: "Oops!", message: "Please enter your last name.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)
        } else if !isValidEmail(testStr: txtFieldEmail.text!) {
            let alert = UIAlertController(title: "Oops!", message: "Please enter correct email address.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)
        } else if !validateCountryCode(value: txtFieldCountryCode.text!) {
            let alert = UIAlertController(title: "Oops!", message: "Please enter correct country code.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)

        } else if !validateMobileNo(value: txtFieldMobileNo.text!) {
            let alert = UIAlertController(title: "Oops!", message: "Please enter correct mobile no.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)
        } else if txtFieldPassword.text == "" {
            let alert = UIAlertController(title: "Oops!", message: "Please enter correct password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)
        } else if txtFieldConfirmPassword.text == "" {
            let alert = UIAlertController(title: "Oops!", message: "Please confirm your password.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)
        } else if txtFieldPassword.text != txtFieldConfirmPassword.text {
            let alert = UIAlertController(title: "Oops!", message: "Please confirm your password again.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)

        } else if txtFieldDOB.text == "" {
            let alert = UIAlertController(title: "Oops!", message: "Please enter valid DOB", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)
        } else if txtViewAboutYou.text == "" {
            let alert = UIAlertController(title: "Oops!", message: "Please write something about you.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)

        } else if txtFieldDOB.text == currentDateString {
            let alert = UIAlertController(title: "Oops!", message: "Please enter valid DOB", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let fullName: String = txtFieldFirstName.text! + " " + txtFieldLastName.text!
            let alert = UIAlertController(title: "Oops!", message: "Congratulations! \(fullName) your account has been created successfully", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
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
        let COUNTRY_CODE_REGEX = "^\\d{2}$"
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

