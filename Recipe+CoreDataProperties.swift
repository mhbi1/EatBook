//
//  Recipe+CoreDataProperties.swift
//  EatBook
//
//  Created by Michael Bi on 4/19/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }
 
    @NSManaged public var category: Int16
    @NSManaged public var directions: [String]
    @NSManaged public var image: NSData?
    @NSManaged public var rName: String?
    @NSManaged public var ingredientRel: [Ingredient]
    
    // Get Functions
    func getName() -> String{
        return rName!
    }
    
    func getCategory() -> Int16{
        return category
    }
    
    func getDirections() -> [String]{
        return directions
    }
    
    func getIngredients() -> [Any]?{
        return ingredientRel
    }
    /*func getImage() -> UIIImage{
     return image
     }*/
    
    // Add Functions
    func addRName(n: String){
        rName = n
    }
    
    func addCategory(i: Int16){
        category = i
    }
    
    func addDirections(d: [String]){
        directions = d
    }
    
    /*func addImage(){
     
     }*/

}

// MARK: Generated accessors for ingredientRel
extension Recipe {

    @objc(addIngredientRelObject:)
    @NSManaged public func addToIngredientRel(_ value: Ingredient)

    @objc(removeIngredientRelObject:)
    @NSManaged public func removeFromIngredientRel(_ value: Ingredient)

    @objc(addIngredientRel:)
    @NSManaged public func addToIngredientRel(_ values: NSSet)

    @objc(removeIngredientRel:)
    @NSManaged public func removeFromIngredientRel(_ values: NSSet)

}
