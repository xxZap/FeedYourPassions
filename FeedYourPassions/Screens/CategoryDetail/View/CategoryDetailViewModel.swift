//
//  CategoryDetailViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 25/04/24.
//

import SwiftUI
import Combine

class CategoryDetailViewModel: ObservableObject {
    @Published var category: AsyncResource<OPassionCategory>?

    private var cancellables = Set<AnyCancellable>()
    private let selectedCategoryController: SelectedCategoryController

    init(selectedCategoryController: SelectedCategoryController) {
        self.selectedCategoryController = selectedCategoryController

        selectedCategoryController.selectedCategory
            .receive(on: DispatchQueue.main )
            .sink { [weak self] asyncSelectedCategory in
                self?.category = asyncSelectedCategory
            }
            .store(in: &cancellables)
    }

    func createNewPassion() {
        // ZAPTODO: missing implementation
        print("Presenting new Passion creation form")
        // on save, call:
        // selectedCategoryController.addNewPassion(newPassion)
    }

    func createNewRecord(record: OPassionRecord, to passionID: OPassionID) {
        selectedCategoryController.addNewRecord(record, to: passionID)
    }
}
