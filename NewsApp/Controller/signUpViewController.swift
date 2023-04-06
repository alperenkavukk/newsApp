//
//  signUpViewController.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 3.04.2023.
//

import UIKit
import FirebaseAuth

class signUpViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        signUpbutton.layer.cornerRadius = 20
        emailText.layer.cornerRadius = 15
        passwordText.layer.cornerRadius = 15
        passwordText.isSecureTextEntry = true
        passwordText.textContentType = .password
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) {
                authdata , error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "ERROR")
                }
                else
                {
                    self.performSegue(withIdentifier: "tocustomvc", sender: nil)
                }
            }
        }
        else {
            self.makeAlert(titleInput: "Error!", messageInput: "Username/Password")
        }
        
    }
    
    func makeAlert(titleInput:String, messageInput:String) {
               let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
               let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
               alert.addAction(okButton)
               self.present(alert, animated: true, completion: nil)
          }
    
}
