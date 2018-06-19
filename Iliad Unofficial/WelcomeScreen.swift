//
//  WelcomeScreen.swift
//  Iliad Unofficial
//
//  Created by Michele Gravina on 11/06/18.
//  Copyright © 2018 Michele Gravina. All rights reserved.
//

import UIKit

class WelcomeScreen: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginIdentText: UITextField!
    @IBOutlet weak var loginPwdText: UITextField!
    
    
    
    @IBAction func accediButton(_ sender: Any) {
        if checkloginIdentText(identityString: loginIdentText.text!) {
            // Login is in valid format
           
            loginIdent = loginIdentText.text!
            loginPwd = loginPwdText.text!
            doLogin { (dataResult) in
                if dataResult == 1 {
                    self.performSegue(withIdentifier: "italiaSegue", sender: nil)
                } else {
                    // Invalid Login, alertController presented to user
                    let alertController = UIAlertController(title: "Accesso negato", message: "ID utente o password errati.", preferredStyle: .alert)
                    let firstActionButton = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
                        print(">>>    Accesso negato    <<<\n>>>   Utente avvisato   <<<")
                    }
                    alertController.addAction(firstActionButton)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Manage the editing and validation of fields
        loginIdentText.delegate = self
        loginPwdText.delegate = self
        
    }
    
    func checkloginIdentText(identityString: String) -> Bool {
        if identityString.isEmpty {
            // UserID is empty
            let alertController = UIAlertController(title: "Attenzione!", message: "La User ID è vuota.", preferredStyle: .alert)
            // Initialize Actions
            let firstActionButton = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
                print(">>> User ID vuota <<<")
            }
            // Add Actions
            alertController.addAction(firstActionButton)
            self.present(alertController, animated: true, completion: nil)
            return false
        }
        // Check if identityString contains number only and if so return true
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: identityString)) {
            // identityString contains number only
            return true
        } else {
            let alertController = UIAlertController(title: "Attenzione!", message: "La User ID deve essere composta da soli numeri.", preferredStyle: .alert)
            // Initialize Actions
            let firstActionButton = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
                print(">>> User ID errata <<<")
            }
            // Add Actions
            alertController.addAction(firstActionButton)
            self.present(alertController, animated: true, completion: nil)
            return false
        }
    }
    
    func checkloginPwdText(passwordString: String) -> Bool {
        if passwordString.isEmpty {
            // Password is empty
            let alertController = UIAlertController(title: "Attenzione!", message: "La password è vuota.", preferredStyle: .alert)
            // Initialize Actions
            let firstActionButton = UIAlertAction(title: "Ok", style: .default) { (action) -> Void in
                print(">>> Password vuota <<<")
            }
            // Add Actions
            alertController.addAction(firstActionButton)
            self.present(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if loginIdentText.isFirstResponder {
            if checkloginIdentText(identityString: loginIdentText.text!) {
                // UserID is formerly correct
                // The focus was on login field, pass the focus to password field
                loginPwdText.becomeFirstResponder()
                return true
            } else {
                return false
            }
        } else {
            // The focus was on password field, resign to first responder and go to login()
            if checkloginPwdText(passwordString: loginPwdText.text!) {
                loginPwdText.resignFirstResponder()
                //doLogin()
                return true
            } else {
                return false
            }
        }
    }
        
        @IBAction func didTapScreen(_ sender: Any) {
            if loginIdentText.isFirstResponder {
                if checkloginIdentText(identityString: loginIdentText.text!) {
                    // UserID is formerly correct
                    // The focus was on login field, pass the focus to password field
                    loginPwdText.becomeFirstResponder()
                }
            } else {
                if loginPwdText.isFirstResponder {
                    loginPwdText.resignFirstResponder()
                }
            }
        }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
        
}

