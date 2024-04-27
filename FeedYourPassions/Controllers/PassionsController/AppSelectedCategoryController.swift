//
//  AppSelectedCategoryController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 26/04/24.
//

import Foundation
import Combine
import Factory

extension Container {
    var selectedCategoryController: Factory<SelectedCategoryController> {
        Factory(self) {
            AppSelectedCategoryController(passionsController: Container.shared.passionsController())
        }.singleton
    }
}

class AppSelectedCategoryController: SelectedCategoryController {

    private let _selectedCategory: CurrentValueSubject<AsyncResource<OPassionCategory>?, Never>
    var selectedCategory: AnyPublisher<AsyncResource<OPassionCategory>?, Never> {
        _selectedCategory.eraseToAnyPublisher()
    }

    var maxValue: Int {
        _selectedCategory.value?.successOrNil?.maxValue ?? 0
    }

    private let passionsController: PassionsController
    private var cancellables = Set<AnyCancellable>()

    init(passionsController: PassionsController) {
        self.passionsController = passionsController
        self._selectedCategory = CurrentValueSubject(.loading)

        passionsController.categories
            .combineLatest(passionsController.selectedCategoryID)
            .receive(on: DispatchQueue.main )
            .sink { asyncCategories, asyncSelectedCategoryID in
                asyncCategories.asyncMap { [weak self] categories in
                    if let asyncSelectedCategoryID = asyncSelectedCategoryID {
                        asyncSelectedCategoryID.asyncMap { [weak self] selectedCategoryID in
                            guard let category = categories.first(where: { $0.id == selectedCategoryID }) else {
                                self?._selectedCategory.send(.failure(NSError()))
                                return
                            }
                            self?._selectedCategory.send(.success(category))
                        }
                    } else {
                        self?._selectedCategory.send(nil)
                    }
                }
            }
            .store(in: &cancellables)
    }

    func addNewPassion(_ passion: OPassion) {
        guard let selectedCategoryID = _selectedCategory.value?.successOrNil?.id else { return }
        passionsController.addNewPassion(passion, to: selectedCategoryID)
    }

    func addNewRecord(_ record: OPassionRecord, to passionID: OPassionID) {
        guard let selectedCategoryID = _selectedCategory.value?.successOrNil?.id else { return }
        passionsController.addNewRecord(record, to: selectedCategoryID, and: passionID)
    }
}
