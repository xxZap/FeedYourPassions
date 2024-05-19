//
//  CategoryDetailUIState.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import Foundation

struct CategoryDetailUIState {
    var category: PassionCategory?
    var passions: [Passion]?
}

//typealias CategoryDetailOnAddRecordResult = (record: PassionRecord, passionID: PassionID)
struct CategoryDetailCalls {
    var onCreatePassionTap: (() -> Void)
//    var onAddRecord: (CategoryDetailOnAddRecordResult) -> Void
}
