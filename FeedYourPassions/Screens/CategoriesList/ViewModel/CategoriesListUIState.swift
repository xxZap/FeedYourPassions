//
//  CategoriesListUIState.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 03/05/24.
//

import Foundation

struct CategoriesListUIState {
    let categories: [Category]?
    let selectedCategoryType: PassionCategoryType?
    let maxValue: Int
}

struct CategoriesListCalls {
    var onCategoryTap: (Category?) -> Void
}
