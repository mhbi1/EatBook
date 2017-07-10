//
//  RecipeViewController.swift
//  EatBook
//
//  Created by Michael Bi on 4/16/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    
    @IBOutlet weak var rImage: UIImageView!
    @IBOutlet weak var rName: UILabel!
    @IBOutlet weak var rCategory: UILabel!
    @IBOutlet weak var ingredientView: UITextView!
    @IBOutlet weak var directionView: UITextView!
    
    public var name: String = ""
    public var category: Int = 0
    public var ingredients: [Ingredient] = []
    public var direction: [String] = []
    public var image: Data?
    
    func getImage() -> UIImage{
        return UIImage(data: image!)!
    }
    
    func getCategory(c: Int) -> String{
        /* 0 - Breakfast/Brunch
           1 - Lunch
           2 - Appetizers/Snacks
           3 - Entrees: Chicken
           4 - Entrees: Beef
           5 - Entrees: Other
           6 - Desserts */
        var type = ""
        if (c == 0) { type = "Breakfast/Brunch"}
        else if (c == 1) { type = "Lunch"}
        else if (c == 2) { type = "Appetizers/Snacks"}
        else if (c == 3) { type = "Entrees: Chicken"}
        else if (c == 4) { type = "Entrees: Beef"}
        else if (c == 5) { type = "Entrees: Other"}
        else if (c == 6) { type = "Desserts"}
        
        return type
    }
    
    func getMeasurementType(m: Int) -> String{
        /* 0 - teaspons (tsp)
         1 - tablespoons (tbsp)
         2 - cup
         3 - ounces (oz)
         4 - pounds (lbs)*/
        var type = ""
        if (m == 0) { type = "tsp"}
        else if (m == 1) { type = "tbsp"}
        else if (m == 2) { type = "cup(s)"}
        else if (m == 3) { type = "oz"}
        else if (m == 4) { type = "lb(s)"}
        
        return type
    }
    
    func getDirections() -> String{
        var direct = ""
        if (direction.count != 0){
            //Goes through array of directions and adds to text
            for i in 1...direction.count{
                direct += "\(i)) \(direction[i-1]).\n"
            }
        }
        
        return direct
    }
    
    func getIngredients() -> String{
        var list = ""
        
        if (ingredients.count != 0){
            //Goes through array of Ingredients
            for i in 0...ingredients.count-1{
                // Creates temp var to hold current ingredient
                let ingred: Ingredient = ingredients[i]
                let t = getMeasurementType(m: Int(ingred.getMeasurement()))
                
                list += "\(ingred.getIName()), \(ingred.getAmountString()) \(t)       \n"
            }
        }
        return list
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rName.text = name
        rCategory.text = getCategory(c: category)
        directionView.text = getDirections()
        directionView.layer.borderWidth = 1
        ingredientView.text = getIngredients()
        ingredientView.layer.borderWidth = 1
        rImage.image = getImage()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
