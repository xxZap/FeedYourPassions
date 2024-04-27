//
//  CategoriesListViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation
import Combine

class CategoriesListViewModel: ObservableObject {

    @Published var categories: AsyncResource<[OPassionCategory]> = .loading
    var maxValue: Int { categories.successOrNil?.map { $0.currentValue }.max() ?? 0 }

    private var cancellables = Set<AnyCancellable>()
    private let passionsController: PassionsController

    init(passionsController: PassionsController) {
        self.passionsController = passionsController

        passionsController.categories
            .sink { [weak self] categories in
                let sortedCategories = categories.asyncMap { $0.sorted(by: { $0.currentValue > $1.currentValue }) }
                self?.categories = sortedCategories
            }
            .store(in: &cancellables)
    }

    func setSelectedCategory(_ categoryID: OPassionCategoryID?) {
        passionsController.setSelectedCategory(categoryID)
    }
}
