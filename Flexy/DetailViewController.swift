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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundUrl = URL(string:self.backgroundPosterString)!
        
        let smallPosterUrl = URL(string:self.smallPosterString)!
        
        backgroundPosterImage.af_setImage(withURL: backgroundUrl)
        smallPosterImage.af_setImage(withURL:smallPosterUrl)
        
        self.movieTitle.text = movieTitleString
        self.dateLabel.text = dateLabelString
        self.overViewLable.text = overViewLabelString
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
