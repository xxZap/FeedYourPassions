//
//  PassionRecord.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 26/05/24.
//

import Foundation
import FirebaseFirestore

class PassionRecord: Equatable, Hashable, Codable {
    @DocumentID var id: String?
    let date: Timestamp

    init(date: Date) {
        self.date = Timestamp(date: date)
    }

    static func == (lhs: PassionRecord, rhs: PassionRecord) -> Bool {
        lhs.id == rhs.id
        && lhs.date == rhs.date
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
    }
}
