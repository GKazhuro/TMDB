//
//  ViewController.swift
//  TMDB
//
//  Created by Георгий Кажуро on 07.09.16.
//  Copyright © 2016 Георгий Кажуро. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let API_KEY = "33cc3e142714fd03168b364ab92aaccf"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var message: UILabel!
    
    var query: String!
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        Configuration.instance.createConfiguration()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        let leftSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleTableSwipes))
        let rightSwipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleTableSwipes))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(tap)
        tableView.addGestureRecognizer(leftSwipe)
        tableView.addGestureRecognizer(rightSwipe)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        query = "Fight Club"
        searchMovie(query)
    }
    
    func handleTableSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.state == .ended) {
            let swipeLocation = sender.location(in: self.tableView)
            if let swipedIndexPath = tableView.indexPathForRow(at: swipeLocation) {
                if let swipedCell = tableView.cellForRow(at: swipedIndexPath) as? MovieViewCell {
                    if sender.direction == .left {
                        swipedCell.showFavoriteView()
                    } else if sender.direction == .right {
                        swipedCell.hideFavoriteView()
                    }
                }
            }
        }
    }
    
    func searchMovie(_ query:String) {
        let urlQuery = query.replace(" ", withString: "+")
        let urlString = "http://api.themoviedb.org/3/search/movie?query=\(urlQuery)&api_key=\(API_KEY)"
        if let url = URL(string: urlString) {
        
            let session = URLSession.shared
        
            session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject] {
                            if let results = json["results"] as? [[String:AnyObject]] {
                                DispatchQueue.main.async(execute: { () -> Void in
                                    self.movies.removeAll()
                                    if results.count > 0 {
                                        self.tableView.isHidden = false
                                        self.message.isHidden = true
                                    } else {
                                        self.tableView.isHidden = true
                                        self.message.isHidden = false
                                    }
                                    for movie in results {
                                        let movieObj = Movie(movieDict: movie)
                                        print(movieObj.posterPaths["original"])
                                        self.movies.append(movieObj)
                                        self.tableView.reloadData()
                                    }
                                })
                            }
                        }
                    } catch {
                        print("Could not serialize json")
                    }
                }
            }) .resume()
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != "" || searchBar.text != nil {
            searchMovie(searchBar.text!.lowercased())
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if movies.count > 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell") as? MovieViewCell {
                cell.poster.image = nil
                let movie = movies[(indexPath as NSIndexPath).row]
                cell.configureCell(movie)
                if let path = movie.posterPaths["w185"] {
                    cell.poster.downloadedFrom(path)
                } else {
                    cell.poster.image = UIImage(named: "default_poster")
                }
                return cell
            } else {
                return MovieViewCell()
            }
        } else {
            return MovieViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


}

