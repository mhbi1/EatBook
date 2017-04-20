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
    var ingredientsData: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    var recipes = [Recipe]()
    
    @IBOutlet weak var recipeTable: UITableView!
    
    func fetchList() {
        // Fetches the request, executes and adds to the array
        recipes = ((try? recipeData.fetch(Recipe.fetchRequest())))!
    }
    
    // Datasource method that is called when table is loaded
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //If no recipes
        if (recipes.count == 0){
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No recipes available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            return recipes.count
        }
        else{
            //fetchList()
            return recipes.count
        }
    }
    
    // This datasource method will create each cell of the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        
        if (recipes.count != 0){
            // Get the LogItem for this index
            let r = recipes[indexPath.row]
            print("Creating cells...")
            
            cell.textLabel?.text = r.getName()
            cell.detailTextLabel?.textAlignment = .right
            
            /*let cell_Image = context.value(forKey: "image") as? Data
             cell.imageView?.image = UIImage(data: cell_Image!)*/
            
        }
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
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            recipeTable.reloadData()
        }
    }

    
    // segue will be called as a row of the table is selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toRView"){
            let selectedIndex: IndexPath = self.recipeTable.indexPath(for: sender as! UITableViewCell)!
            // Creates copy of recipes in core data and sends attributes to recipeView
            let r = recipes[selectedIndex.row]
            
            if let vc: RecipeViewController = segue.destination as? RecipeViewController {
                vc.name = r.getName()
                vc.category = Int(r.getCategory())
                vc.ingredients = r.getIngredients() as! [Ingredient]
                vc.direction = r.getDirections()
                //vc.image = r.getImage()
            }
        }
        else if (segue.identifier == "toAdd"){
          
        }
    }

    @IBAction func backToRList(segue: UIStoryboardSegue){
        //fetchList()
        self.recipeTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchList()
        recipeTable.rowHeight = UITableViewAutomaticDimension
        //recipeTable.estimatedRowHeight = 35
        recipeTable.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
