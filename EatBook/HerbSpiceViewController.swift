//
//  HerbSpiceViewController.swift
//  EatBook
//
//  Created by Michael Bi on 4/16/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import UIKit
import WebKit

class HerbSpiceViewController: UIViewController {

    public var urlString: String?
    
    var webView:WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        self.view = self.webView!

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let url = URL(string: urlString!)
        let req = URLRequest(url:url!)
        self.webView!.load(req)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
