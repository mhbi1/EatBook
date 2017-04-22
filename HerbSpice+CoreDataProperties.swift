//
//  HerbSpice+CoreDataProperties.swift
//  EatBook
//
//  Created by Michael Bi on 4/17/17.
//  Copyright © 2017 Michael Bi. All rights reserved.
//

import Foundation
import CoreData


extension HerbSpice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HerbSpice>{
        let request = NSFetchRequest<HerbSpice>(entityName: "HerbSpice")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        return request
    }
    
    @NSManaged public var name: String?
    @NSManaged public var url: String?

    public func getName() -> String{
        return name!
    }
    
    public func getURL() -> String{
        return url!
    }
    
    public func setName(n: String){
        name = n
    }
    
    public func setURL(u: String){
        url = u
    }
    
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, name: String, url: String) {
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "HerbSpice", into: moc) as! HerbSpice
        newItem.name = name
        newItem.url = url
        
        //return newItem
    }
    
}
