//
//  WelcomeViewController.swift
//  QChat
//
//  Created by Sohel Dhengre on 13/03/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit
import ProgressHUD

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: IBActions
    
    @IBAction func loginPressed(_ sender: Any) {
        dismissKeyboard()
        if emailTextField.text != "" && passwordTextField.text != "" {
            loginUser()
        } else {
            ProgressHUD.showError("Email And Password is missing!")
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        dismissKeyboard()
        if emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != "" {
            if passwordTextField.text == repeatPasswordTextField.text {
                registerUser()
            } else {
                ProgressHUD.showError("Passwords don't match!")
            }
        } else {
            ProgressHUD.showError("All Fields are required!")
        }
    }
    
    @IBAction func backgroundTap(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    //MARK: Helper Functions
    
    func loginUser() {
        ProgressHUD.show("Loging In...")
        FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            self.goToApp()
        }
    }
    
    func registerUser() {
        dismissKeyboard()
        performSegue(withIdentifier: "fromWelcomeToFinishRegistration", sender: self)
        cleanTextFields()
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func cleanTextFields(){
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        self.repeatPasswordTextField.text = ""
    }
    
    func goToApp() {
        ProgressHUD.dismiss()
        cleanTextFields()
        dismissKeyboard()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION), object: nil, userInfo: [kUSERID: FUser.currentId()])
        
        let mainVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainApplication") as! UITabBarController
        present(mainVC, animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromWelcomeToFinishRegistration" {
            let vc = segue.destination as! FinishRegistrationViewController
            vc.email = self.emailTextField.text!
            vc.password = self.passwordTextField.text
        }
    }
}
