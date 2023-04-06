//
//  NewsInfoViewController.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 5.04.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class NewsInfoViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    
    var news:Article?
    var likesArray = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = news?.author
        infoTextNews()
        
    }
    
    @IBAction func fullNewsbutton(_ sender: Any) {
        guard let urlString = news?.url, let url = URL(string: urlString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:]) { success in
                print("2")
                if !success {
                    print("Failed to open URL:", url)
                    
                }
            }
        }
        
        
    }
    func infoTextNews(){
        
        let textView = UITextView(frame: CGRect(x: 8, y: 390, width: 372, height: 382))
        textView.text = "FA Cup'ta Manchester United'a 3-1 kaybeden Fulham'da Aleksandar Mitrovic'in hakeme yaptığı itirazdan sonra gördüğü kırmızı kartın faturası açıklandı. Tecrübeli forvete 8 maç men cezası verildi.73. dakikada bir pozisyonun ardından Chris Kanavagh'ı koluyla dürtüp itirazda bulunan Mitrovic, kırmızı kart gördü. Yaşananların ardından pişman olduğunu ve özür dilediğini dilediğini açıklayan Mitrovic'in bu adımı cezayı hafifletmeye yetmedi. Futbolcuya ayrıca para cezası da kesildi.FA'den yapılan açıklamada, şiddet içeren davranışın yanı sıra Mitrovic'in aşağılayıcı ve tehdit edici bir dil kullanmasından ötürü 8 maç ceza verildiğini bildirdi. Ayrıca futbolcuya tam 75 bin sterlin para cezası kesildi.Futbolseverler, Mitrovic'e verilen 8 maçlık ceza ve 75 bin sterlinlik para cezasının çok ağır olduğunu ifade etti. Sosyal medyada tepki paylaşımları görüldü"
        
        textView.isScrollEnabled = true
        self.view.addSubview(textView)
        image.image = UIImage(named: "breakinNews")
        titlelabel.text = news?.title
        
        if let publishedAt = news?.publishedAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from: publishedAt) {
                let interval = Date().timeIntervalSince(date)
                let formatter = DateComponentsFormatter()
                formatter.unitsStyle = .abbreviated
                formatter.allowedUnits = interval < 3600 ? [.minute] : [.hour]
                formatter.maximumUnitCount = 1
                formatter.zeroFormattingBehavior = .dropAll
                let timeAgo = formatter.string(from: interval)!
                dateLabel.text = String(timeAgo)
            }
        }
        
    }
    var likeDone = false
    @IBAction func likeButtonClicked(_ sender: Any) {
        guard let news = news else { return }
            
            let db = Firestore.firestore()
        let newsRef = db.collection("News").document(news.source.id?.rawValue ?? "")
            
            if !likeDone {
                newsRef.updateData(["likeCount": FieldValue.increment(Int64(1))])
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                likeDone = true
            } else {
                newsRef.updateData(["likeCount": FieldValue.increment(Int64(-1))])
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                likeDone = false
            }
      
    }
    
    
    @IBAction func shareButtonClicked(_ sender: Any) {
    }
    @IBAction func saveNewsButtonClicked(_ sender: Any) {
        
        let db = Firestore.firestore()
        let NewsRef = db.collection("SaveNews")
        let query = NewsRef.whereField("NewsTitle", in: [title])
        query.getDocuments { querySnapshot, error in
            if let error = error {
                print("error")
            }
            else  {
                NewsRef.addDocument(data: ["NewsTitle": self.news?.title ?? "error","date": self.news?.publishedAt ?? "8 dk önce","postedby": Auth.auth().currentUser?.email])
                if let error = error {
                    print("hata oluştu")
                }
                else {
                    print("veri başarı ile eklendi")
                }
            }
        }
    }
}
