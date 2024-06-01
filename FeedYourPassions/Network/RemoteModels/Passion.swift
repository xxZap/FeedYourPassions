//
//  Passion.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation
import FirebaseFirestore

class Passion: Equatable, Hashable, Codable {
    @DocumentID var id: String?
    var name: String
    var associatedURL: String?
    var recordsCount: Int
    var latestUpdate: Timestamp
    var color: String

    init(name: String, associatedURL: String? = nil, recordsCount: Int, latestUpdate: Timestamp, color: String) {
        self.name = name
        self.associatedURL = associatedURL
        self.recordsCount = recordsCount
        self.latestUpdate = latestUpdate
        self.color = color
    }

    static func == (lhs: Passion, rhs: Passion) -> Bool {
        lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.associatedURL == rhs.associatedURL
        && lhs.recordsCount == rhs.recordsCount
        && lhs.latestUpdate == rhs.latestUpdate
        && lhs.color == rhs.color
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(associatedURL)
        hasher.combine(recordsCount)
        hasher.combine(latestUpdate)
        hasher.combine(color)
    }
}
