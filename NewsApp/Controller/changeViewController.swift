//
//  changeViewController.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 12.04.2023.
//

import UIKit
import FirebaseAuth
class changeViewController: UIViewController {

    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var againNewpassword: UITextField!
    @IBOutlet weak var newPasswor: UITextField!
    @IBOutlet weak var oldpassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        changeButton.layer.cornerRadius = 20
        againNewpassword.layer.cornerRadius = 15
        newPasswor.layer.cornerRadius = 15
        oldpassword.isSecureTextEntry = true
        oldpassword.textContentType = .password
        againNewpassword.isSecureTextEntry = true
        againNewpassword.textContentType = .password
        newPasswor.isSecureTextEntry = true
        newPasswor.textContentType = .password


        

    }
    
    @IBAction func changebuttonClicked(_ sender: Any) {
        guard let oldPassword = oldpassword.text, !oldPassword.isEmpty else {
            self.makeAlert(titleInput: "Erro", messageInput: "Old password field cannot be left blank.")
                return
            }
            
            guard let newPassword = newPasswor.text, !newPassword.isEmpty else {
                self.makeAlert(titleInput: "Erro", messageInput: "The new password field cannot be left blank.")
                return
            }
            
            guard let againNewPassword = againNewpassword.text, !againNewPassword.isEmpty else {
                self.makeAlert(titleInput: "Error", messageInput: "The new password field cannot be left blank.")
                return
            }
            
            if newPassword != againNewPassword {
                self.makeAlert(titleInput: "Error", messageInput: "Passwords do not match")
                return
            }
            
            
            Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
                if let error = error {
                   
                    print("Şifre değiştirme işlemi sırasında hata oluştu: \(error.localizedDescription)")
                    return
                }
                
                self.makeAlert(titleInput: "Successful", messageInput: "Password changed successfully")
                print("Şifre başarıyla değiştirildi.")
                
               }
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alertController = UIAlertController(title:titleInput, message: messageInput, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
