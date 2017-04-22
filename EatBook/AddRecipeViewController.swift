//
//  AddRecipeViewController.swift
//  EatBook
//
//  Created by Michael Bi on 4/19/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import UIKit
import CoreData


class AddRecipeViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var rName: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var iAmount: UITextField!
    @IBOutlet weak var measurement: UITextField!
    @IBOutlet weak var iName: UITextField!
    @IBOutlet weak var direction: UITextField!
    
    @IBOutlet weak var directionView: UITextView!
    @IBOutlet weak var ingredientView: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    public var iList: [Ingredient] = []
    public var dList: [String] = []
    var recipeListVC: RecipeListViewController = RecipeListViewController()
    var m: Int = 0
    var c: Int = 0
    var a: Double = 0.0
    var aItems = [["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"], [" ", "3/4", "1/2", "1/4"]]
    var mItems = ["tsp", "tbsp", "cup(s)", "oz", "lb(s)"]
    var cItems = ["Breakfast/Brunch", "Lunch", "Appetizers/Snacks", "Entrees: Chicken", "Entrees: Beef", "Entrees: Other", "Desserts"]
    var activeField: UITextField?
    
    
    @IBAction func saveRecipe(_ sender: UIBarButtonItem) {
        let ent = NSEntityDescription.entity(forEntityName: "Recipe", in: recipeListVC.recipeData)
        let newRecipe = Recipe(entity: ent!, insertInto: recipeListVC
            .recipeData)
        
        newRecipe.addRName(n: rName.text!)
        newRecipe.addCategory(i: Int16(c))
        newRecipe.addDirections(d: dList)
        for i in iList{ newRecipe.addToIngredientRel(i) }
        newRecipe.addImage(i: (UIImagePNGRepresentation(image.image!)!))
        
        do {
            try recipeListVC.recipeData.save()
        } catch _ {}
       
        self.performSegue(withIdentifier: "addToList", sender: self)
    }
    
    
    @IBAction func addIngredient(_ sender: UIButton) {
        let ent = NSEntityDescription.entity(forEntityName: "Ingredient", in: recipeListVC.ingredientsData)
        let newItem = Ingredient(entity: ent!, insertInto: recipeListVC.ingredientsData)
        newItem.addIName(n: iName.text!)
        newItem.addAmount(d: a)
        newItem.addMeasurement(i: Int16(m))
        
        do{
            try recipeListVC.ingredientsData.save()
        
            iList.append(newItem)
        } catch _ {}
        updateIngredients()
    }
    
    @IBAction func addDirection(_ sender: UIButton) {
        dList.append(direction.text!)
        updateDirections()
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        // display image selection view
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    @IBAction func useCamera(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        self.present(picker,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        picker .dismiss(animated: true, completion: nil)
        image.image=info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func updateIngredients(){
        var list = ""
        for i in iList{
            list += "\(i.getAmountString()) \(mItems[Int(i.getMeasurement())])   \t\t\t   \(i.getIName())\n"
        }
        ingredientView.text = list
        iName.text = ""
    }
    
    func updateDirections(){
        var list = ""
        for d in 1...dList.count{
            list += "\(d)) \(dList[d-1]).\n"
        }
        directionView.text = list
        direction.text = ""
    }
    
    func keyboardWillShow(_ notification: Notification) {
        //self.view.frame.origin.y = -260 // Move view 150 points upward
        if let activeField = activeField, let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: keyboardSize.height + 115.0, right: scrollView.contentInset.right)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            var aRect = scrollView.frame
            aRect.size.height -= keyboardSize.size.height
            //Sets the scroll view constraints
            if (!aRect.contains(activeField.frame.origin)) {
                scrollView.scrollRectToVisible(activeField.frame, animated: true)
                
            }
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets(top: 59.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        scrollView.isScrollEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
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
            self.view.endEditing(true)
        }
        else if (pickerView.tag == 1) {
            measurement.text = mItems[row]
            m = row
            self.view.endEditing(true)
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
        
        //Setup for pickerview
        category.inputView = cPicker
        measurement.inputView = mPicker
        iAmount.inputView = aPicker
        
        cPicker.tag = 0
        mPicker.tag = 1
        aPicker.tag = 2
        
        //Allows for keyboard show/hide
        NotificationCenter.default.addObserver(self, selector: #selector(AddRecipeViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(AddRecipeViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        rName.delegate = self
        iName.delegate = self
        direction.delegate = self
        activeField?.delegate = self
        
        scrollView.keyboardDismissMode = .interactive
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
