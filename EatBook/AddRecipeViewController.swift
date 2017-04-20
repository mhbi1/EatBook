//
//  AddRecipeViewController.swift
//  EatBook
//
//  Created by Michael Bi on 4/19/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import UIKit
import CoreData


class AddRecipeViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var rName: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var iAmount: UITextField!
    @IBOutlet weak var measurement: UITextField!
    @IBOutlet weak var iName: UITextField!
    @IBOutlet weak var direction: UITextField!
    
    @IBOutlet weak var directionView: UITextView!
    @IBOutlet weak var ingredientView: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    public var iList: [Ingredient] = []
    public var dList: [String] = []
    var recipeListVC: RecipeListViewController = RecipeListViewController()
    var m: Int = 0
    var c: Int = 0
    var a: Double = 0.0
    var aItems = [["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"], [" ", "3/4", "1/2", "1/4"]]
    var mItems = ["tsp", "tbsp", "cup(s)", "oz", "lb(s)"]
    var cItems = ["Breakfast/Brucnh", "Lunch", "Appetizers/Snacks", "Entrees: Chicken", "Entrees: Beef", "Entrees: Other", "Desserts"]
    var ingredientsData: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    
    @IBAction func saveRecipe(_ sender: UIBarButtonItem) {
        let ent = NSEntityDescription.entity(forEntityName: "Recipe", in: recipeListVC.recipeData)
        let newRecipe = Recipe(entity: ent!, insertInto: recipeListVC
            .recipeData)
        
        newRecipe.addRName(n: rName.text!)
        newRecipe.addCategory(i: c)
        for i in iList{ newRecipe.addToIngredientRel(i) }
        newRecipe.addDirections(d: dList)
        
        do {
            try recipeListVC.recipeData.save()
        } catch _ {}
        
        print(newRecipe)
        self.performSegue(withIdentifier: "addToList", sender: self)
    }
    
    
    @IBAction func addIngredient(_ sender: UIButton) {
        let ent = NSEntityDescription.entity(forEntityName: "Ingredient", in: self.ingredientsData)
        let newItem = Ingredient(entity: ent!, insertInto: self.ingredientsData)
        newItem.addIName(n: iName.text!)
        newItem.addAmount(d: a)
        newItem.addMeasurement(i: m)
        
        iList.append(newItem)
        updateIngredients()
    }
    
    @IBAction func addDirection(_ sender: UIButton) {
        dList.append(direction.text!)
        updateDirections()
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
    }
    
    func updateIngredients(){
        var list = ""
        for i in iList{
            list += "\(i.getAmount()) \(mItems[i.getMeasurement()])        \(i.getIName()))\n"
        }
        ingredientView.text = list
    }
    
    func updateDirections(){
        var list = ""
        for d in 1...dList.count{
            list += "\(d). \(dList[d-1]).\n"
        }
        directionView.text = list
        direction.text = ""
    }
    
    //Number of columns in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if (pickerView.tag == 2){ return aItems.count }
        else{ return 1 }
    }
    
    //Number of rows in components
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0) { return cItems.count}
        else if (pickerView.tag == 1) { return mItems.count}
        else { return aItems[component].count}
    }
    
    //Set name of each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0) { return cItems[row]}
        else if (pickerView.tag == 1)  { return mItems[row]}
        else { return aItems[component][row]}
    }
    
    //Updates textfield with name
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 0) {
            category.text = cItems[row]
            c = row
        }
        else if (pickerView.tag == 1) {
            measurement.text = mItems[row]
            m = row
        }
        else {
            let w = aItems[0][pickerView.selectedRow(inComponent: 0)]
            let f = aItems[1][pickerView.selectedRow(inComponent: 1)]
            
            iAmount.text = w + " "  + f
            
            if (f == "3/4"){
                a = Double(w)! + 0.75
            }
            else if (f == "1/2"){
                a = Double(w)! + 0.5
            }
            else if (f == "1/4"){
                a = Double(w)! + 0.25
            }
            else{
                a = Double(w)!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Sets up two pickerViews
        let cPicker = UIPickerView()
        let mPicker = UIPickerView()
        let aPicker = UIPickerView()
        cPicker.delegate = self
        mPicker.delegate = self
        aPicker.delegate = self
        
        category.inputView = cPicker
        measurement.inputView = mPicker
        iAmount.inputView = aPicker
        
        cPicker.tag = 0
        mPicker.tag = 1
        aPicker.tag = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}