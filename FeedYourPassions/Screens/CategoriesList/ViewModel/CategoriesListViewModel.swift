//
//  CategoriesListViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation
import Combine

class CategoriesListViewModel: ObservableObject {

    @Published var uiState: CategoriesListUIState = .loading

    private var cancellables = Set<AnyCancellable>()
    private let passionsController: PassionsController

    init(passionsController: PassionsController) {
        self.passionsController = passionsController

        passionsController.categories
            .sink { [weak self] categories in
                _ = categories
                    .asyncMap { 
                        self?.uiState = .success(.init(
                            categories: $0.sorted(by: { $0.currentValue > $1.currentValue }),
                            maxValue: $0.map { $0.currentValue }.max() ?? 0
                        ))
                    }
            }
            .store(in: &cancellables)

        passionsController.fetchCategories()
    }

    func setSelectedCategory(_ categoryID: OPassionCategoryID?) {
        passionsController.setSelectedCategory(categoryID)
    }
}
