//
//  DetailViewController.swift
//  Flexy
//
//  Created by Divyaraj Bakrola on 2/17/19.
//  Copyright © 2019 Divyaraj Bakrola. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var backgroundPosterImage: UIImageView!
    
    var backgroundPosterString:String!
    
    @IBOutlet weak var smallPosterImage: UIImageView!
    
    var smallPosterString:String!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    var movieTitleString:String!
    
   
    @IBOutlet weak var dateLabel: UILabel!
    
    var dateLabelString:String!
    
    @IBOutlet weak var overViewLable: UILabel!
    
    var overViewLabelString:String!
    
    var id:Int!
    
    var trailerString:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(id)
        
        
        self.getMovieTrailerString()
        
        let backgroundUrl = URL(string:self.backgroundPosterString)!
        
        let smallPosterUrl = URL(string:self.smallPosterString)!
        
        backgroundPosterImage.af_setImage(withURL: backgroundUrl)
        smallPosterImage.af_setImage(withURL:smallPosterUrl)
        
        self.movieTitle.text = movieTitleString
        self.dateLabel.text = dateLabelString
        self.overViewLable.text = overViewLabelString
        
    }
    
    func getMovieTrailerString() {
        
        
        let url = URL(string:"http://api.themoviedb.org/3/movie/\(self.id!)/videos?api_key=3ca4232e03c4d16ac675e3a84a6128ad")!
        
        
        let request = URLRequest(url:url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) {
            
            (data, response, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
                
            else if let data = data {
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                let trailers = dataDictionary["results"] as! [[String:Any]]
                
                
                let key = trailers[0]["key"] as! String
                print(key)
                self.trailerString = "https://www.youtube.com/watch?v=\(key)"
                
                print(self.trailerString)
                
            }
        }
        
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print(trailerString)
        
        
        if segue.identifier == "trailer" {
            
            let destination = segue.destination as! TrailerViewController
            destination.webUrl = self.trailerString
        }
    }
    
    
    @IBAction func onPlayButtonClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "trailer", sender: nil)
    }
    
}
