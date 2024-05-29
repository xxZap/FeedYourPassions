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

    private var category: Category? { categoryDetailController.category }
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

    func rename(passion: Passion, into name: String?) {
        guard let name = name, name.count > 2 else {
            alert = AppAlert.Error.PassionNameLength(onDismiss: { [weak self] in
                self?.alert = nil
            })
            return
        }

        categoryDetailController.rename(passion, into: name)
    }

    func setAssociatedURL(_ url: String?, to passion: Passion) {
        categoryDetailController.setAssociatedURL(url ?? "", to: passion)
    }

    func setColor(_ color: String, to passion: Passion) {
        categoryDetailController.setColor(color, to: passion)
    }

    func addNewRecord(for date: Date, to passion: Passion) {
        alert = AppAlert.Confirmation.AddNewRecord(passionName: passion.name, date: date) { [weak self] confirmed in
            if confirmed {
                let record = PassionRecord(date: date)
                self?.categoryDetailController.addRecord(record, to: passion)
            }

            self?.alert = nil
        }
    }

    func delete(passion: Passion) {
        alert = AppAlert.Confirmation.DeletePassion(passionName: passion.name) { [weak self] confirmed in
            if confirmed {
                self?.categoryDetailController.delete(passion)
            }

            self?.alert = nil
        }
    }
}
