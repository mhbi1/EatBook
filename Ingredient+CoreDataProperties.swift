//
//  Ingredient+CoreDataProperties.swift
//  EatBook
//
//  Created by Michael Bi on 4/19/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var amount: Double
    @NSManaged public var iName: String?
    @NSManaged public var measurement: Int
    @NSManaged public var recipeRel: Recipe?
    
    // Get Functions
    func getIName() -> String{
        return iName!
    }
    
    func getAmount() -> Double{
        return amount
    }
    
    func getMeasurement() -> Int{
        return measurement
    }
    func getRecipe() -> Recipe{
        return recipeRel!
    }
    
    // Add Functions
    func addIName(n: String){
        iName = n
    }
    
    func addAmount(d: Double){
        amount = d
    }
    
    func addMeasurement(i: Int){
        measurement = i
    }
    
}
