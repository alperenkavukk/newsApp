//
//  signUpViewController.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 3.04.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class signUpViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageViewAdd: UIImageView!
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        signUpbutton.layer.cornerRadius = 20
        emailText.layer.cornerRadius = 15
        passwordText.layer.cornerRadius = 15
        passwordText.isSecureTextEntry = true
        passwordText.textContentType = .password
        imageViewAdd.layer.cornerRadius = imageViewAdd.frame.size.width / 3
        imageViewAdd.clipsToBounds = true
        
        imageViewAdd.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageViewAdd.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func chooseImage(){
        let pickercontroller = UIImagePickerController()
        pickercontroller.delegate = self
        pickercontroller.sourceType = .photoLibrary
        present(pickercontroller , animated: true,completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageViewAdd.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func signUpButton(_ sender: Any) {
        
        
        guard let email = emailText.text, let password = passwordText.text, let username = usernameTextField.text else {
               return
           }
           
           
           Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
               if error == nil {
                   
                   let db = Firestore.firestore()
                   db.collection("users").document(result!.user.uid).setData(["username": username])
                
                   self.performSegue(withIdentifier: "tocustomvc", sender: self)
               } else {
                   
                   let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                   let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alertController.addAction(alertAction)
                   self.present(alertController, animated: true, completion: nil)
               }
           }
        
    }

}

