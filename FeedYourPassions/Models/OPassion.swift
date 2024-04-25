//
//  OPassion.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

class OPassionRecord: Equatable, Hashable {

    let date: Date

    init(date: Date) {
        self.date = date
    }

    static func == (lhs: OPassionRecord, rhs: OPassionRecord) -> Bool {
        lhs.date == rhs.date
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}

typealias OPassionID = UUID

class OPassion: Equatable, Hashable {
    let id: OPassionID
    var name: String
    var associatedURL: String?
    var records: [OPassionRecord]

    init(name: String, associatedURL: String? = nil, records: [OPassionRecord]) {
        self.id = OPassionID()
        self.name = name
        self.associatedURL = associatedURL
        self.records = records
    }

    static func == (lhs: OPassion, rhs: OPassion) -> Bool {
        lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.associatedURL == rhs.associatedURL
        && lhs.records == rhs.records
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(associatedURL)
        hasher.combine(records)
    }
}
