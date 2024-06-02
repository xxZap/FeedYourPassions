//
//  CategoriesListViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Combine
import Factory
import Foundation

class CategoriesListViewModel: ObservableObject {

    @Published var uiState: CategoriesListUIState = .init(categories: nil, selectedCategoryType: nil, maxValue: 0)

    private var cancellables = Set<AnyCancellable>()

    @Injected(\.categoriesController) private var categoriesController

    init() {
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

    func setSelectedCategory(_ category: CategoryContainer?) {
        categoriesController.selectCategory(category)
    }
}
