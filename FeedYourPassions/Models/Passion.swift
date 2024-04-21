//
//  Passion.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

struct PassionRecord: Equatable {
    let date: Date
}

struct Passion: Equatable {
    let name: String
    let associatedURL: String?
    let records: [PassionRecord]
}
