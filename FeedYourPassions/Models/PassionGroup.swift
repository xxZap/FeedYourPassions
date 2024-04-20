//
//  PassionGroup.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

struct PassionGroup: Equatable {
    var name: String
    var passions: [Passion]

    var currentValue: Int {
        passions.isEmpty ? 0 : passions.map { $0.currentValue }.reduce(0, +)
    }
}
