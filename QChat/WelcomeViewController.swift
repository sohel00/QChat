//
//  WelcomeViewController.swift
//  QChat
//
//  Created by Sohel Dhengre on 13/03/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit

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
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        dismissKeyboard()
    }
    
    @IBAction func backgroundTap(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    //MARK: Helper Functions
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func cleanTextFields(){
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        self.repeatPasswordTextField.text = ""
    }
}
