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
    @Published var maxValue: Int

    private var cancellables = Set<AnyCancellable>()
    private let passionsController: PassionsController

    init(passionsController: PassionsController) {
        self.passionsController = passionsController
        self.maxValue = 0

        passionsController.categories
            .sink { [weak self] categories in
                guard let self = self else { return }
                let sortedCategories = categories.asyncMap { $0.sorted(by: { $0.currentValue > $1.currentValue }) }
                self.categories = sortedCategories
                self.maxValue = sortedCategories.successOrNil?.map { $0.currentValue }.max() ?? 0
            }
            .store(in: &cancellables)
    }

    func setSelectedCategory(_ categoryID: OPassionCategoryID?) {
        passionsController.setSelectedCategory(categoryID)
    }
}
