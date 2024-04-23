//
//  CategoriesListViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

class CategoriesListViewModel {

    let categories: [OPassionCategory]
    var maxValue: Int { categories.map { $0.currentValue }.max() ?? 0 }

    init(categories: [OPassionCategory]) {
        self.categories = categories.sorted(by: { $0.currentValue > $1.currentValue })
    }
}
