//
//  CategoriesListUIState.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 03/05/24.
//

import Foundation

typealias CategoriesListUIState = AsyncResource<CategoriesListUIContent>

struct CategoriesListUIContent {
    let categories: [OPassionCategory]
    let maxValue: Int
}

struct CategoriesListCalls {
    var onCategoryTap: (OPassionCategory) -> Void
}
