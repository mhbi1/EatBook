//
//  Ingredient+CoreDataProperties.swift
//  EatBook
//
//  Created by Michael Bi on 4/20/17.
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
    @NSManaged public var measurement: Int16
    @NSManaged public var recipeRel: Recipe?

    // Get Functions
    func getIName() -> String{
        return iName!
    }
    
    func getAmount() -> Double{
        return amount
    }
    
    func getMeasurement() -> Int16{
        return measurement
    }
    
    // Add Functions
    func addIName(n: String){
        iName = n
    }
    
    func addAmount(d: Double){
        amount = d
    }
    
    func addMeasurement(i: Int16){
        measurement = i
    }
    
    // Converts the double to a string
    func getAmountString() -> String{
        var str = ""
        let num = amount * 4.0
        let quo = Int(num / 4)
        let rem = num.truncatingRemainder(dividingBy: 4)
        if (rem == 1){
            str = "\(quo) 1/4"
        }
        else if (rem == 2){
            str = "\(quo) 1/2"
        }
        else if (rem == 3){
            str = "\(quo) 3/4"
        }
        else{
            str = "\(quo)"
        }
        return str
    }
}
