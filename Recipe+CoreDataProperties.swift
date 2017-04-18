//
//  Recipe+CoreDataProperties.swift
//  EatBook
//
//  Created by Michael Bi on 4/17/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var category: Int16
    @NSManaged public var directions: NSObject?
    @NSManaged public var image: NSData?
    @NSManaged public var ingredients: NSObject?
    @NSManaged public var rName: String?

}
