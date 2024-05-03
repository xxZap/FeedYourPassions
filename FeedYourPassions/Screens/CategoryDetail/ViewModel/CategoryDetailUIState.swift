//
//  CategoryDetailUIState.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import Foundation

typealias CategoryDetailUIState = AsyncResource<CategoryDetailUIContent>

struct CategoryDetailUIContent {
    var category: OPassionCategory
}

typealias CategoryDetailOnAddRecordResult = (record: OPassionRecord, passionID: OPassionID)
struct CategoryDetailCalls {
    var onCreatePassion: (() -> Void)
    var onAddRecord: (CategoryDetailOnAddRecordResult) -> Void
}
