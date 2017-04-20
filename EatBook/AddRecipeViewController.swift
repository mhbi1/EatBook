//
//  AddRecipeViewController.swift
//  EatBook
//
//  Created by Michael Bi on 4/19/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import UIKit


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
    
    public var newRecipe: Recipe = Recipe()
    public var iList: [Ingredient] = []
    public var dList: [String] = []
    var m: Int = 0
    var c: Int = 0
    var mItems = ["tsp", "tbsp", "cup"]
    var cItems = ["Breakfast/Brucnh", "Lunch", "Appetizers/Snacks", "Entrees: Chicken", "Entrees: Beef", "Entrees: Other", "Desserts"]
    
    
    @IBAction func saveRecipe(_ sender: UIBarButtonItem) {
        newRecipe.addRName(n: rName.text!)
        newRecipe.addCategory(i: c)
        for i in iList{
             newRecipe.addToIngredientRel(i)
        }
        newRecipe.addDirections(d: dList)
        print(newRecipe)
    }
    
    
    @IBAction func addIngredient(_ sender: UIButton) {
        let newItem = Ingredient()
        newItem.addIName(n: iName.text!)
        newItem.addAmount(d: Double(iAmount.text!)!)
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
        for d in 0...dList.count{
            list += "\(d). \(dList[d])).\n"
        }
        directionView.text = list
    }
    
    //Number of columns in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Number of rows in components
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0) { return cItems.count}
        else { return mItems.count}
    }
    
    //Set name of each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0) { return cItems[row]}
        else { return mItems[row]}
    }
    
    //Updates textfield with name
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 0) {
            category.text = cItems[row]
            c = row
        }
        else {
            measurement.text = mItems[row]
            m = row
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Sets up two pickerViews
        let cPicker = UIPickerView()
        let mPicker = UIPickerView()
        cPicker.delegate = self
        mPicker.delegate = self
        
        category.inputView = cPicker
        measurement.inputView = mPicker
        
        cPicker.tag = 0
        mPicker.tag = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
