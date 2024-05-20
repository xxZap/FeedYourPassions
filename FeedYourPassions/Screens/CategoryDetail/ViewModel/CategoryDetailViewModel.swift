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
    @Published var alert: AppAlert?

    private(set) var category: PassionCategory?
    private let categoriesController: CategoriesController
    private let categoryDetailController: CategoryDetailController
    private var cancellables = Set<AnyCancellable>()

    init(
        category: PassionCategory,
        categoriesController: CategoriesController,
        categoryDetailController: CategoryDetailController
    ) {
        self.category = category
        self.categoriesController = categoriesController
        self.categoryDetailController = categoryDetailController
        self.uiState = .init(category: category, passions: nil)

        categoryDetailController.passions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] passions in
                self?.uiState = .init(category: self?.category, passions: passions)
            }
            .store(in: &cancellables)
    }

    func createNewPassion() {
        // ZAPTODO: missing implementation
        print("Presenting new Passion creation form")
        // on save, call:
        // selectedCategoryController.addNewPassion(newPassion)
    }

    func rename(passion: Passion, into name: String?) {
        guard let name = name, name.count > 2 else {
            alert = AppAlert.Error.PassionNameLength(onDismiss: { [weak self] in
                self?.alert = nil
            })
            return
        }

        categoryDetailController.rename(passion, into: name)
    }

    func setAssociatedURL(passion: Passion, url: String?) {
        categoryDetailController.setAssociatedURL(passion, url: url ?? "")
    }
}
