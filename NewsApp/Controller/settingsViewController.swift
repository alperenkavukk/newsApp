//
//  settingsViewController.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 12.04.2023.
//

import UIKit
import FirebaseAuth
class settingsViewController: UIViewController {
    
    var headers = ["Account","More Features","Support"]
    var accounts = ["My Account","Change My Password"]
    var morefeatures = ["Profit&Loss","announcement"]
    var support = ["Privacy Policy","Terms And Condition","LogOut"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        tableView.sectionHeaderTopPadding = 0
        registerTableCells()
        
    }
    
    
    func registerTableCells(){
        tableView.register(UINib(nibName: "headerTitleCell", bundle: nil), forCellReuseIdentifier: "headerTitleCell")
        
    }
}

extension settingsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return accounts.count
        case 1:
            return morefeatures.count
        case 2:
            return support.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerTitleCell") as! headerTitleCell
        cell.titles.font = UIFont.systemFont(ofSize: 15)
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        switch indexPath.section {
        case 0:
            cell.titles.text = accounts[indexPath.row]
        case 1 :
            cell.titles.text = morefeatures[indexPath.row]
        case 2:
            cell.titles.text = support[indexPath.row]
        default:
           return  UITableViewCell()
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerTitleCell") as! headerTitleCell
        cell.titles.font = UIFont.systemFont(ofSize: 20)
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.titles.text = headers[section]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 60
        case 1:
            return 60
        case 2:
            return 60
        default:
            return 60
            
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 40
        case 1:
            return 40
        case 2:
            return 40
        default:
            return 40
        
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 20
        case 1:
            return 20
        case 2:
            return 20
        default:
            return 20
        
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 1 {
                
                self.performSegue(withIdentifier: "toChangepassword", sender: nil)
                      }
            break
        case 1:
           
           
            break
        case 2:
            
            if indexPath.row == 2 {
                do {
                    try Auth.auth().signOut()
                   
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginVC = storyboard.instantiateViewController(withIdentifier: "loginViewController")
                    UIApplication.shared.keyWindow?.rootViewController = loginVC
                } catch {
                   
                    print("Error signing out: \(error.localizedDescription)")
                }
            }
            break
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }


}
