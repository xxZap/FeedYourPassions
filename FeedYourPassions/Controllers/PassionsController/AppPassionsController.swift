//
//  AppPassionsController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/04/24.
//

import Foundation
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

    func fetchCategories() {
        _categories.send(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self._categories.send(.success(mockedCategories))
        }
    }

    func setSelectedCategory(_ id: OPassionCategoryID?) {
        if let id = id {
            _selectedCategoryID.send(.success(id))
        } else {
            _selectedCategoryID.send(nil)
        }
    }

    func addNewPassion(_ passion: OPassion, to categoryID: OPassionCategoryID) {
        guard let (categories, category, index) = getCategoryIndex(categoryID) else { return }

        category.passions.append(passion)

        var updatedCategories = categories
        updatedCategories[index] = category
        _categories.send(.success(updatedCategories))
    }

    func addNewRecord(_  record: OPassionRecord, to categoryID: OPassionCategoryID, and passionID: OPassionID) {
        guard
            let (categories, category, categoryIndex) = getCategoryIndex(categoryID),
            let (_, passion, passionIndex) = getPassionIndex(passionID, from: category)
        else {
            return
        }

        passion.records.append(record)
        category.passions[passionIndex] = passion

        var updatedCategories = categories
        updatedCategories[categoryIndex] = category
        _categories.send(.success(updatedCategories))
    }
}

private extension AppPassionsController {
    private func getCategoryIndex(
        _ categoryID: OPassionCategoryID
    ) -> (categories: [OPassionCategory], category: OPassionCategory, index: Int)? {
        guard
            let categoryIndex = _categories.value.successOrNil?.firstIndex(where: { $0.id == categoryID }),
            let categories = _categories.value.successOrNil
        else {
            return nil
        }

        let category = categories[categoryIndex]
        return (categories, category, categoryIndex)
    }

    private func getPassionIndex(
        _ passionID: OPassionID,
        from category: OPassionCategory
    ) -> (passions: [OPassion], passion: OPassion, index: Int)? {
        guard
            let passionIndex = category.passions.firstIndex(where: { $0.id == passionID })
        else {
            return nil
        }

        let passion = category.passions[passionIndex]
        return (category.passions, passion, passionIndex)
    }
}
