//
//  OPassion.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

struct OPassionRecord: Equatable, Hashable {
    let date: Date
}

struct OPassion: Equatable, Hashable {
    let id: UUID
    let name: String
    let associatedURL: String?
    let records: [OPassionRecord]
}
