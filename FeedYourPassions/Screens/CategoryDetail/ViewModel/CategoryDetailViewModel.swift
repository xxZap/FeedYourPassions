//
//  CategoryDetailViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 25/04/24.
//

import Foundation
import Combine

class CategoryDetailViewModel: ObservableObject {
    @Published var uiState: CategoryDetailUIState?

    private var cancellables = Set<AnyCancellable>()
    private let selectedCategoryController: SelectedCategoryController

    init(selectedCategoryController: SelectedCategoryController) {
        self.selectedCategoryController = selectedCategoryController

        selectedCategoryController.selectedCategory
            .receive(on: DispatchQueue.main )
            .sink { [weak self] asyncSelectedCategory in
                if let asyncSelectedCategory {
                    _ = asyncSelectedCategory.asyncMap { [weak self] value in
                        self?.uiState = .success(CategoryDetailUIContent(category: value))
                    }
                } else {
                    self?.uiState = nil
                }
            }
            .store(in: &cancellables)
    }

    func createNewPassion() {
        // ZAPTODO: missing implementation
        print("Presenting new Passion creation form")
        // on save, call:
        // selectedCategoryController.addNewPassion(newPassion)
    }

    func addNewRecord(record: OPassionRecord, to passionID: OPassionID) {
        selectedCategoryController.addNewRecord(record, to: passionID)
    }
}
