//
//  Passion.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

struct OPassionRecord: Equatable {
    let date: Date
}

struct OPassion: Equatable {
    let name: String
    let associatedURL: String?
    let records: [OPassionRecord]
}
