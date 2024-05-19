//
//  CategoriesListViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation
import Combine

class CategoriesListViewModel: ObservableObject {

    @Published var uiState: CategoriesListUIState = .init(categories: nil, maxValue: 0)

    private var cancellables = Set<AnyCancellable>()
    private let categoriesController: CategoriesController

    init(categoriesController: CategoriesController) {
        self.categoriesController = categoriesController

        categoriesController.passionCategories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.uiState = .init(
                    categories: categories?.sorted(by: { $0.currentValue > $1.currentValue }),
                    maxValue: categories?.map { $0.currentValue }.max() ?? 0
                )
            }
            .store(in: &cancellables)
    }

    func setSelectedCategory(_ category: PassionCategory?) {
        categoriesController.selectCategory(category)
    }
}
