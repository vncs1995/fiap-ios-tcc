//
//  State+CoreDataProperties.swift
//  Vinicius
//
//  Created by VINICIUS VIANA DOS SANTOS on 31/01/21.
//
//

import Foundation
import CoreData


extension State {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<State> {
        return NSFetchRequest<State>(entityName: "State")
    }

    @NSManaged public var name: String?
    @NSManaged public var tax: Float
    @NSManaged public var ofProduct: Product?

}

extension State : Identifiable {

}
