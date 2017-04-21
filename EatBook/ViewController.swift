//
//  ViewController.swift
//  EatBook
//
//  Created by Michael Bi on 3/20/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func quit(_ sender: UIButton) {
        exit(0)
    }
    
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue){
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

