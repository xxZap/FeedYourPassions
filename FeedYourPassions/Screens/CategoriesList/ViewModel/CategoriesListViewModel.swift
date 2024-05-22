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

        categoriesController.passionCategories
            .combineLatest(categoriesController.selectedCategory)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories, selectedCategory in
                self?.uiState = .init(
                    categories: categories?.sorted(by: { $0.currentValue > $1.currentValue }),
                    selectedCategoryType: selectedCategory?.type,
                    maxValue: categories?.map { $0.currentValue }.max() ?? 0
                )
            }
            .store(in: &cancellables)
    }

    func setSelectedCategory(_ category: PassionCategory?) {
        categoriesController.selectCategory(category)
    }
}
