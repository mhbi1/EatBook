//
//  RecipeListViewController.swift
//  EatBook
//
//  Created by Michael Bi on 4/13/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import UIKit
import CoreData

class RecipeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var recipeData: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    
    var fetchResults = [Recipe]()
    var name: String = ""
    
    @IBOutlet weak var recipeTable: UITableView!
    
    func fetchRecord() -> Int {
        //     print("Fetching...")
        // Create a new fetch request using the LogItem entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        var x = 0
        // Execute the fetch request, and cast the results to an array of LogItem objects
        fetchResults = ((try? recipeData.fetch(fetchRequest)) as? [Recipe])!
        
        x = fetchResults.count
        print(x)
        return x
    }
    
    @IBAction func loadTable(_ sender: Any) {
        recipeTable.reloadData()
    }
    
    // Datasource method that is called when table is loaded
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRecord()
    }
    
    // This datasource method will create each cell of the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let context:NSManagedObjectContext = recipeData
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)
        //cell.textLabel?.text = fetchResults[indexPath.row].name
        cell.detailTextLabel?.textAlignment = .right
        
        
        /*let cell_Image = context.value(forKey: "image") as? Data
         cell.imageView?.image = UIImage(data: cell_Image!)*/
        
        return cell
    }
    
    // This allows the table to be editted
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    // This will delete the cell array that it selects
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        let context:NSManagedObjectContext = recipeData
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            context.delete(fetchResults[indexPath.row])
            fetchResults.remove(at: indexPath.row)
            do{
                try recipeData.save()
            } catch _ {
            }
            recipeTable.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
