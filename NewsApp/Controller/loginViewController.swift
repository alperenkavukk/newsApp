//
//  loginViewController.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 3.04.2023.
//

import UIKit
import FirebaseAuth

class loginViewController: UIViewController {

    @IBOutlet weak var emailtext: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var loginbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginbutton.layer.cornerRadius = 20
        emailtext.layer.cornerRadius = 15
        passwordText.layer.cornerRadius = 15
        
        passwordText.isSecureTextEntry = true
        passwordText.textContentType = .password
    }
    

  
    @IBAction func loginbuttonclickedd(_ sender: Any) {
        
        if emailtext.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailtext.text!, password: passwordText.text!){
                authdata , error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "error")
                }else{
                    
                    self.performSegue(withIdentifier: "totabBarVc", sender: nil)
            }
            
        }
    }
        else {
            self.makeAlert(titleInput: "EROR", messageInput: "USERNAME/PASSWORD NOT Found")
        }
        
    }
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVc", sender: nil)
    }
    
    
    
    func makeAlert(titleInput:String, messageInput:String) {
               let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
               let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
               alert.addAction(okButton)
               alert.present(alert, animated: true, completion: nil)
          }
}
