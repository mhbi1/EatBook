//
//  SubsitutesViewController.swift
//  EatBook
//
//  Created by Michael Bi on 4/21/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import UIKit

class SubsitutesViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var ingredient: UITextField!
    @IBOutlet weak var success: UILabel!
    @IBOutlet weak var results: UITextView!
    
    @IBOutlet weak var search: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
