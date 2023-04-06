//
//  anaSayfaViewController.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 3.04.2023.
//

import UIKit

class anaSayfaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionview: UICollectionView!
    
   
    let images = ["news","blueNews","newsPaper","signUp","tabletNews"]
    let haberSitesi = ["hürriyet","milliyet","fanatik","fotomaç","sadads"]
    var haberData = [Article]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return haberData.count
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCellCollectionViewCell
                
        let article = haberData[indexPath.item]
        let oge = haberData[indexPath.row]
        cell.infoLabel.text = article.title
        cell.pauthercompany.text = article.author
        cell.likeLabel.text = String("5")
        
        if let imageUrl = article.urlToImage {
              cell.image.downloaded(from: imageUrl)
          } else {
              cell.image.image = UIImage(named: "news")
          }
        
           var  timeNews = oge.publishedAt
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
       /* if let cell = collectionView.cellForItem(at: indexPath) {
               cell.contentView.backgroundColor = UIColor.black
               cell.contentView.alpha = 0.5
           }*/
        performSegue(withIdentifier: "toDestionVc", sender: indexPath)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDestionVc" {
            guard let destinationVC = segue.destination as? NewsInfoViewController else {
                print("Destination view controller could not be opened")
                return
            }
            guard let indexPath = sender as? IndexPath else {
                print("Sender is not of type IndexPath")
                return
            }
            let selectedData = haberData[indexPath.row]
            print("Selected data: \(selectedData)")
            destinationVC.news = selectedData
            print("Destination view controller's news property: \(destinationVC.news)")
        }
    }
    
    

    
    func getData() {
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?country=tr&apiKey=4e623c3c25a14c5b84b3143f1d2dcfa8") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(News.self, from: data!)
                    self.haberData = response.articles
                    DispatchQueue.main.async {
                        self.collectionview.reloadData()
                    }
                } catch let error {
                    print("Error: \(error.localizedDescription)")
                }
            }
            task.resume()
            
        }
    }


}




extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
