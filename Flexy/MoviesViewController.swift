//
//  MoviesViewController.swift
//  Flexy
//
//  Created by Divyaraj Bakrola on 2/7/19.
//  Copyright © 2019 Divyaraj Bakrola. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet var TableView: UITableView!
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.dataSource = self
        TableView.delegate = self
        TableView.rowHeight = 150
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.TableView.reloadData()
                print(dataDictionary)
                
            }
        }
        task.resume()
        
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let Synopsis = movie["overview"] as! String
        
        print(title)
        
        cell.titleLabel.text = title
        cell.SynopsisLabel.text = Synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        cell.posterView.af_setImage(withURL: posterUrl)
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! MovieCell
        let indexPath = self.TableView.indexPath(for:cell)
        let movie = movies[(indexPath?.row)!]
        let destination = segue.destination as! DetailViewController
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let backdropPath = movie["backdrop_path"] as! String
        let posterPath = movie["poster_path"] as! String
        destination.backgroundPosterString = baseUrl + backdropPath
        destination.smallPosterString = baseUrl + posterPath
        destination.overViewLabelString = movie["overview"] as! String
        destination.dateLabelString = movie["release_date"] as! String
    }

}
