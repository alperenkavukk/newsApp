//
//  registerNewsViewController.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 9.04.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class registerNewsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var items = [(NewsTitle: String, postedBy: String, date: String, newsAuthor : String, documantId: String, urlnews: String)]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromFirestore()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        
        navigationItem.title = "Registered News"
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "registerCell", for: indexPath) as! registerNewsCollectionViewCell
        
        let item = items[indexPath.row]
        cell.newsTitle.text = item.newsAuthor
        cell.infoLabel.text = item.NewsTitle
        var  timeNews = item.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: timeNews) {
            let interval = Date().timeIntervalSince(date)
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .abbreviated
            formatter.allowedUnits = interval < 3600 ? [.minute] : [.hour]
            formatter.maximumUnitCount = 1
            formatter.zeroFormattingBehavior = .dropAll
            let timeAgo = formatter.string(from: interval)!
            cell.dateLabel.text = String(timeAgo)
            
        }
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = MyItem(newsTitle: items[indexPath.row].NewsTitle,
                                   postedBy: items[indexPath.row].postedBy,
                                   date: items[indexPath.row].date,
                                   newsAuthor: items[indexPath.row].newsAuthor,
                                   documantId: items[indexPath.row].documantId,
                                  urlnews: items[indexPath.row].urlnews
                                   )
      //  items.remove(at: indexPath.row)
       //     collectionView.deleteItems(at: [indexPath])
            
           
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "NewsInfoViewController") as! NewsInfoViewController
        destinationVC.selectedItem = selectedItem
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }

  
    func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            
            let documentID = self.items[indexPath.row].documantId
            
         
            Firestore.firestore().collection("SaveNews").document(documentID).delete() { (error) in
                if let error = error {
                    print("Error deleting document: \(error)")
                } else {
                    print("Document successfully deleted!")
                }
            }
            
            
            self.items.remove(at: indexPath.row)
            
           
            collectionView.deleteItems(at: [indexPath])
            
            completion(true)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    
    
    
    
    
    public func getDataFromFirestore(){
           let db = Firestore.firestore()
           let userRef = db.collection("SaveNews")
           let query = userRef.whereField("postedby", in: [Auth.auth().currentUser?.email!])
           query.addSnapshotListener { [self] snapshot, error in
             if error != nil
                 {
                 print("error11")
             }
                 else
                 {
                     if snapshot?.isEmpty != true && snapshot != nil
                     {
                         self.items.removeAll()
                         for document in  snapshot!.documents {
                             
                             let documentId = document.documentID
                             let data = document.data()
                             let title = data["NewsTitle"] as? String ?? ""
                             print("title\(title)")
                             let date = data["date"] as? String ?? ""
                             print("date")
                             let postedBy = data["postedby"] as? String ?? ""
                             print("posted\(postedBy)")
                             let writes = data["author"] as? String ?? ""
                             let urlhaber = data["urlNews"] as? String ?? ""

                             self.items.append((NewsTitle: title, postedBy: postedBy, date: date, newsAuthor: writes, documantId: documentId, urlnews: urlhaber) )
                             
                         

                         }
                         collectionView.reloadData()

                        
                     }
                    
                     }
             
         }

     }

}
