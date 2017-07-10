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
    
    var i: String?
    var result = ""
    var message = ""
    
    func getJsonData(){
        let url = URL(string:"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/ingredients/substitutes?ingredientName=\(i!)")
        var request = URLRequest(url: url!)
        
        request.addValue("DkVEgXxTw3mshjSfHegOjZgTnSIsp13yL0wjsnohN9F4IfeQQG", forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            // Retrieves the jsonResult
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
            print(jsonResult)
            //var r = [String]()
            let found:NSString = jsonResult["status"] as! NSString
            
            
            DispatchQueue.main.async(execute: {
                if (found == "success"){
                    let m:NSString = jsonResult["message"] as! NSString
                    let subs:NSArray = jsonResult["substitutes"] as! NSArray
                    let name:NSString = jsonResult["ingredient"] as! NSString
                    self.success.text! = m as String
                    self.results.text! += "Substitutes for \(name as String): \n\n"
                    for i in 0...subs.count-1{
                            self.results.text! += "\(subs[i] as! String) \n"
                    }
                    
                }
                else{
                    self.success.text! = "Substitutes not found"
                }
            })
        })
        
        jsonQuery.resume()
        
    }
    
    @IBAction func searchForSubsitute(_ sender: UIButton) {
        i = ingredient.text!
        getJsonData()
        ingredient.text = ""
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SubsitutesViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ingredient.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
