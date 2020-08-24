//
//  Member+CoreDataProperties.swift
//  CoredataCodeCrew
//
//  Created by Vijay on 23/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//
//

import Foundation
import CoreData


extension Member {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member> {
        return NSFetchRequest<Member>(entityName: "Member")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var gender: String?

}
