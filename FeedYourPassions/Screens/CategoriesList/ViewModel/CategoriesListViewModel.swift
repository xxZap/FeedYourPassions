//
//  CategoriesListViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation
import Combine

class CategoriesListViewModel: ObservableObject {

    @Published var uiState: CategoriesListUIState

    private var cancellables = Set<AnyCancellable>()
    private let categoriesController: CategoriesController

    init(categoriesController: CategoriesController) {
        self.categoriesController = categoriesController
        self.uiState = .init(categories: nil, selectedCategoryType: nil, maxValue: 0)

        categoriesController.categories
            .combineLatest(categoriesController.selectedCategory)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] asyncCategories, selectedCategory in
                self?.uiState = .init(
                    categories: asyncCategories?.asyncMap { categories in
                        categories.sorted(by: { $0.maxValue > $1.maxValue })
                    },
                    selectedCategoryType: selectedCategory?.passionCategory.type,
                    maxValue: asyncCategories?.successOrNil?.map { $0.maxValue }.max() ?? 0
                )
            }
            .store(in: &cancellables)
    }

    func setSelectedCategory(_ category: Category?) {
        categoriesController.selectCategory(category)
    }
}
