//
//  PassionRecord+CoreDataProperties.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 22/04/24.
//
//

import Foundation
import CoreData


extension PassionRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PassionRecord> {
        return NSFetchRequest<PassionRecord>(entityName: "PassionRecord")
    }

    @NSManaged public var date: Date?
    @NSManaged public var passionID: UUID?

}

extension PassionRecord : Identifiable {

}
