//
//  CategoryDetailViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 25/04/24.
//

import SwiftUI
import Combine
import Foundation

class CategoryDetailViewModel: ObservableObject {
    @Published var uiState: CategoryDetailUIState = .init(category: nil, passions: nil)
    @Published var alert: AppAlert?

    private var category: PassionCategory? { categoryDetailController.category }
    private let categoriesController: CategoriesController
    private let categoryDetailController: CategoryDetailController
    private var cancellables = Set<AnyCancellable>()

    init(
        categoriesController: CategoriesController,
        categoryDetailController: CategoryDetailController
    ) {
        self.categoriesController = categoriesController
        self.categoryDetailController = categoryDetailController

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

    func delete(passion: Passion) {
        alert = AppAlert.Confirmation.DeletePassion(passionName: passion.name) { [weak self] confirmed in
            if confirmed {
                self?.categoryDetailController.delete(passion)
            }
            
            self?.alert = nil
        }
    }

    func setColor(passion: Passion, color: String) {
        categoryDetailController.setColor(passion, color: color)
    }
}
