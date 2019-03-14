//
//  FinishRegistrationViewController.swift
//  QChat
//
//  Created by Sohel Dhengre on 13/03/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit
import ProgressHUD

class FinishRegistrationViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var email:String!
    var password:String!
    var avatarImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(email, password)
    }
    
    //MARK: IBActions
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        cleanTextFields()
        dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        dismissKeyboard()
        ProgressHUD.show("Registering...")
        if nameTextField.text != "" && surnameTextField.text != "" && countryTextField.text != "" && cityTextField.text != "" && phoneNumberTextField.text != "" {
            
            FUser.registerUserWith(email: self.email, password: self.password, firstName: nameTextField.text!, lastName: surnameTextField.text!) { (error) in
                if error != nil {
                    ProgressHUD.dismiss()
                    ProgressHUD.showError(error?.localizedDescription)
                    return
                }
                
                self.registerUser()
            }
        } else {
            ProgressHUD.showError("All fields are required!")
        }
        
    }
    
    //MARK: Helpers
    
    func registerUser() {
        
        let fullName = self.nameTextField.text! + " " + surnameTextField.text!
        var tempDictionary: Dictionary = [kFIRSTNAME:nameTextField.text!, kLASTNAME: surnameTextField.text!, kFULLNAME: fullName, kCOUNTRY: countryTextField.text!, kCITY: cityTextField.text!, kPHONE: phoneNumberTextField.text!] as [String:Any]
        
        if avatarImage == nil {
            
            imageFromInitials(firstName: nameTextField.text!, lastName: surnameTextField.text!) { (avatarInitials) in
                let avatarImage = avatarInitials.jpegData(compressionQuality: 0.6)
                let avatar = avatarImage?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                
                tempDictionary[kAVATAR] = avatar
                
                self.finishRegistration(withvalues: tempDictionary)
            }
        } else {
            
            let avatarData = avatarImage?.jpegData(compressionQuality: 0.6)
            let avatar = avatarData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            
            tempDictionary[kAVATAR] = avatar
            
            self.finishRegistration(withvalues: tempDictionary)
        }
    }
    
    func finishRegistration(withvalues: [String:Any]) {
        
        updateCurrentUserInFirestore(withValues: withvalues) { (error) in
            if error != nil {
                DispatchQueue.main.async {
                    ProgressHUD.showError(error!.localizedDescription)
                    print(error!.localizedDescription)
                }
                return
            }
            
            //Go To App
            ProgressHUD.dismiss()
            self.goToApp()
        }
    }
    
    func goToApp() {
        
        cleanTextFields()
        dismissKeyboard()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION), object: nil, userInfo: [kUSERID: FUser.currentId()])
        
        let mainVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainApplication") as! UITabBarController
        present(mainVC, animated: true, completion: nil)
        
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func cleanTextFields(){
        self.nameTextField.text = ""
        self.surnameTextField.text = ""
        self.countryTextField.text = ""
        self.cityTextField.text = ""
        self.phoneNumberTextField.text = ""
    }
}
