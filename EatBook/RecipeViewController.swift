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
    public var image: UIImage = UIImage()
    
    func getCategory(c: Int) -> String{
        /* 1 - Breakfast/Brunch
           2 - Lunch
           3 - Appetizers/Snacks
           4 - Entrees: Chicken
           5 - Entrees: Beef
           6 - Entrees: Other
           7 - Desserts */
        var type = ""
        if (c == 1) { type = "Breakfast/Brunch"}
        else if (c == 2) { type = "Lunch"}
        else if (c == 3) { type = "Appetizers/Snacks"}
        else if (c == 4) { type = "Entrees: Chicken"}
        else if (c == 5) { type = "Entrees: Beef"}
        else if (c == 6) { type = "Entrees: Other"}
        else if (c == 7) { type = "Desserts"}
        
        return type
    }
    
    func getMeasurementType(m: Int) -> String{
        /* 1 - teaspons (tsp)
         2 - tablespoons (tbsp)
         3 - cup 
         4 - ounces (oz)
         5 - pounds (lbs)*/
        var type = ""
        if (m == 1) { type = "tsp"}
        else if (m == 2) { type = "tbsp"}
        else if (m == 3) { type = "cup(s)"}
        else if (m == 4) { type = "oz"}
        else if (m == 5) { type = "lb(s)"}
        
        return type
    }
    
    func getDirections() -> String{
        var direct = ""
        //Goes through array of directions and adds to text
        for i in 0...direction.count{
            direct += "\(i). \(direction[i]).\n"
        }
        
        return direct
    }
    
    // Converts the double to a string
    func getAmount(i: Ingredient) -> String{
        var str = ""
        let num = i.getAmount() * 4
        let quo = num / 4
        let rem = num.truncatingRemainder(dividingBy: 4)
        if (rem == 1){
            str = "\(quo) 1/4"
        }
        else if (rem == 2){
            str = "\(quo) 2/4"
        }
        else if (rem == 3){
            str = "\(quo) 3/4"
        }
        else{
            str = "\(quo)"
        }
        return str
    }
    
    func getIngredients() -> String{
        var list = ""
        
        //Goes through array of Ingredients
        for i in 0...ingredients.count{
            // Creates temp var to hold current ingredient
            let ingred: Ingredient = ingredients[i]
            let t = getMeasurementType(m: ingred.getMeasurement())
            
            list += "\(getAmount(i: ingred)) \(t)       \(ingred.getIName()) \n"
        }
        
        return list
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rName.text = name
        rCategory.text = getCategory(c: category)
        directionView.text = getDirections()
        ingredientView.text = getIngredients()
        //image here
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
