//
//  TrailerViewController.swift
//  Flexy
//
//  Created by Divyaraj Bakrola on 2/20/19.
//  Copyright © 2019 Divyaraj Bakrola. All rights reserved.
//

import UIKit

import WebKit

class TrailerViewController: UIViewController {
    
    var webUrl:String!
    
    
    @IBOutlet weak var webKit: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string:webUrl)!
        let request = URLRequest(url: url)
        webKit.load(request)
        
        
    }
    


}
