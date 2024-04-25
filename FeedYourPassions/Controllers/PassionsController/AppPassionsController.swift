//
//  AppPassionsController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/04/24.
//

import Combine
import Factory

extension Container {
    var passionsController: Factory<PassionsController> {
        Factory(self) {
            AppPassionsController()
        }.singleton
    }
}

class AppPassionsController: PassionsController {

    private let _categories: CurrentValueSubject<AsyncResource<[OPassionCategory]>, Never>
    var categories: AnyPublisher<AsyncResource<[OPassionCategory]>, Never> {
        _categories.eraseToAnyPublisher()
    }

    private let _selectedCategoryID: CurrentValueSubject<AsyncResource<OPassionCategoryID>?, Never>
    var selectedCategoryID: AnyPublisher<AsyncResource<OPassionCategoryID>?, Never> {
        _selectedCategoryID.eraseToAnyPublisher()
    }

    init() {
        self._categories = CurrentValueSubject(.loading)
        self._selectedCategoryID = CurrentValueSubject(nil)
    }

    func fetchGroups() {
        _categories.send(.loading)
        _categories.send(.success(mockedCategories))
    }

    func setSelectedCategory(id: OPassionCategoryID?) {
        if let id = id {
            _selectedCategoryID.send(.success(id))
        } else {
            _selectedCategoryID.send(nil)
        }
    }

    func addNewPassion(to categoryID: OPassionCategoryID, passion: OPassion) {
        guard let category = getCategory(with: categoryID) else { return }
        category.passions.append(passion)
        // ZAPTODO: implementation to be tested
    }

    func addNewRecord(to passionID: OPassionID, record: OPassionRecord) {
        // ZAPTODO: missing implementation
    }

    private func getCategory(with id: OPassionCategoryID) -> OPassionCategory? {
        _categories.value.successOrNil?.first(where: { $0.id == id })
    }
}
