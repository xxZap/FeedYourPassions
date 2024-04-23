//
//  CategoriesListViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

class CategoriesListViewModel {

    let groups: [OPassionsGroup]
    var maxValue: Int { groups.map { $0.currentValue }.max() ?? 0 }

    init(groups: [OPassionsGroup]) {
        self.groups = groups.sorted(by: { $0.currentValue > $1.currentValue })
    }
}
