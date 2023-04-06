//
//  ViewController.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 3.04.2023.
//

import UIKit

class ViewController: UIViewController {
   
    
    @IBOutlet weak var gobutt: UIButton!
    
 
    @IBOutlet weak var logButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gobutt.layer.cornerRadius = 20
        logButton.layer.cornerRadius = 20
        
        
    }

    
    
    @IBAction func goButtonClickeF(_ sender: Any) {
       

        performSegue(withIdentifier: "toCustamVc", sender: nil)
    }
    
    @IBAction func loginbuttobClicked(_ sender: Any) {
        performSegue(withIdentifier: "toLoginVc", sender: nil)
    }
}

