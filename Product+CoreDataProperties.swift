//
//  Product+CoreDataProperties.swift
//  Vinicius
//
//  Created by VINICIUS VIANA DOS SANTOS on 31/01/21.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var photo: Data?
    @NSManaged public var price: Float
    @NSManaged public var state: State?
    @NSManaged public var creditCard: Bool

}

extension Product : Identifiable {

}
