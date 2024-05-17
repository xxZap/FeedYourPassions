//
//  CategoryDetailViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 25/04/24.
//

import Foundation
import Combine

class CategoryDetailViewModel: ObservableObject {
    @Published var uiState: CategoryDetailUIState

    private(set) var category: PassionCategory
    private let categoriesController: CategoriesController
    private var cancellables = Set<AnyCancellable>()

    init(category: PassionCategory, categoriesController: CategoriesController) {
        self.category = category
        self.categoriesController = categoriesController
        self.uiState = .init(category: category)

        categoriesController.passionCategories
            .receive(on: DispatchQueue.main )
            .sink { [weak self] categories in
                guard
                    let self = self,
                    let updatedCategory = categories?.first(where: { $0.type == self.category.type })
                else {
                    return
                }

                self.category = updatedCategory
                self.uiState = .init(category: updatedCategory)
            }
            .store(in: &cancellables)
    }

    func createNewPassion() {
        // ZAPTODO: missing implementation
        print("Presenting new Passion creation form")
        // on save, call:
        // selectedCategoryController.addNewPassion(newPassion)
    }

//    func addNewRecord(record: PassionRecord, to passionID: PassionID) {
//        selectedCategoryController.addNewRecord(record, to: passionID)
//    }
}
