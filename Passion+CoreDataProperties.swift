//
//  Passion+CoreDataProperties.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 21/04/24.
//
//

import Foundation
import CoreData

//extension Passion {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Passion> {
//        return NSFetchRequest<Passion>(entityName: "Passion")
//    }
//
//    @NSManaged public var name: String?
//    @NSManaged public var associatedURL: String?
//    @NSManaged public var record: NSSet?
//
//    public var recordArray: [PassionRecord] {
//        let set = record as? Set<PassionRecord> ?? []
//        return set.filter{ $0.date != nil }.sorted { $0.wrappedDate > $1.wrappedDate }
//    }
//
//}
//
//// MARK: Generated accessors for record
//extension Passion {
//
//    @objc(addRecordObject:)
//    @NSManaged public func addToRecord(_ value: PassionRecord)
//
//    @objc(removeRecordObject:)
//    @NSManaged public func removeFromRecord(_ value: PassionRecord)
//
//    @objc(addRecord:)
//    @NSManaged public func addToRecord(_ values: NSSet)
//
//    @objc(removeRecord:)
//    @NSManaged public func removeFromRecord(_ values: NSSet)
//
//}
//
//extension Passion : Identifiable {
//
//}
