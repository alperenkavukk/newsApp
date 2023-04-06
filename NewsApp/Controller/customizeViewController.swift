//
//  customizeViewController.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 4.04.2023.
//

import UIKit

class customizeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var kullanbutton: UIButton!
   
    @IBOutlet weak var collectionView: UICollectionView!
    var images = ["spor","bilim","finans","yazılım1","blueNews","signUp","signUp2","borsa","edebiyat","sanat","tarih","eğlence"]
    var isim  =  ["Spor","Bilim","Finans","Yazılım","BlueNews","SignUp","SignUp2","Borsa","Edebiyat","Sanat","Tarih","Eğlence"]
    
    var newsData = [Article]()
    var data = [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.delegate = self
        collectionView.dataSource = self
        //getData()
        kullanbutton.layer.cornerRadius = 28
        
    }
    @IBAction func kullanButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toKullanBarVc", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCellCollectionViewCell
        cell.image.image = UIImage(named: images[indexPath.row])
        
        cell.configur(with: isim[indexPath.row])
        return cell
    }
    
    
    
    
    /*
    
    func getData() {
        let apiUrl =  "https:/**/newsapi.org/v2/top-headlines?country=tr&apiKey=4e623c3c25a14c5b84b3143f1d2dcfa8"
        
        guard let url = URL(string: apiUrl) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            do {
                let decodeData = try JSONDecoder().decode(News.self, from: data)
                self.data = decodeData.articles
                
                DispatchQueue.main.async {
                    print(self.data)
                }
            } catch let error {
                print(error)
            }
        }
        
        task.resume()
    }

    
    */
    
   
}

extension customizeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2 // satırlar arasındaki minimum boşluk
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5// sütunlar arasındaki minimum boşluk
    }
    
}
