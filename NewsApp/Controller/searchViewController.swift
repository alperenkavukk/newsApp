//
//  searchViewController.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 6.04.2023.
//

import UIKit

class searchViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {

    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var searchNewsData = [Result]()
    var data = [Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
               tableView.delegate = self
               
               searchbar.delegate = self
               searchbar.placeholder = "Haber Ara..."
               navigationItem.titleView = searchbar
       
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            if searchText.isEmpty {
                searchNewsData = data
            } else {
                let searchTerm = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                let apiUrl = "https://newsapi.org/v2/everything?q=\(searchTerm)&from=2023-02-06&sortBy=publishedAt&apiKey=4e623c3c25a14c5b84b3143f1d2dcfa8"
                print("apiurl")
                guard let url = URL(string: apiUrl) else {
                    return
                }
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    
                    guard let data = data else {
                        print("Error: Data is nil")
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(SearchNews.self, from: data)
                        self.searchNewsData = response.results
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch let error {
                        print("Error: \(error.localizedDescription)")
                    }
                }

                task.resume()
            }
            
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchNewsData.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let item = searchNewsData[indexPath.row]
            cell.textLabel?.text = item.title
            print("******************urlımage**************")
            print(item.urlToImage)
            
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toMovieVc", sender: self)
        }


}
