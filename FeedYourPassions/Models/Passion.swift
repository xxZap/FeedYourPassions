//
//  OPassion.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation
import FirebaseFirestore

class PassionRecord: Equatable, Hashable, Codable {

    let date: Timestamp

    init(date: Date) {
        self.date = Timestamp(date: date)
    }

    static func == (lhs: PassionRecord, rhs: PassionRecord) -> Bool {
        lhs.date == rhs.date
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}

class Passion: Equatable, Hashable, Codable {
    var name: String
    var associatedURL: String?
    var records: [PassionRecord]

    init(name: String, associatedURL: String? = nil, records: [PassionRecord]) {
        self.name = name
        self.associatedURL = associatedURL
        self.records = records
    }

    static func == (lhs: Passion, rhs: Passion) -> Bool {
        lhs.name == rhs.name
        && lhs.associatedURL == rhs.associatedURL
        && lhs.records == rhs.records
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(associatedURL)
        hasher.combine(records)
    }
}
