//
//  AppPassionsController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/04/24.
//

import Foundation
import Combine
import Factory

//extension Container {
//    var passionsController: Factory<PassionsController> {
//        Factory(self) {
//            AppPassionsController()
//        }.singleton
//    }
//}
//
//class AppPassionsController: PassionsController {
//
//    private let _categories: CurrentValueSubject<AsyncResource<[PassionCategory]>, Never>
//    var categories: AnyPublisher<AsyncResource<[PassionCategory]>, Never> {
//        _categories.eraseToAnyPublisher()
//    }
//
//    private let _selectedCategoryID: CurrentValueSubject<AsyncResource<PassionCategoryID>?, Never>
//    var selectedCategoryID: AnyPublisher<AsyncResource<PassionCategoryID>?, Never> {
//        _selectedCategoryID.eraseToAnyPublisher()
//    }
//
//    init() {
//        self._categories = CurrentValueSubject(.loading)
//        self._selectedCategoryID = CurrentValueSubject(nil)
//    }
//
//    func fetchCategories() {
//        _categories.send(.loading)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self._categories.send(.success(mockedCategories))
//        }
//    }
//
//    func setSelectedCategory(_ id: PassionCategoryID?) {
//        if let id = id {
//            _selectedCategoryID.send(.success(id))
//        } else {
//            _selectedCategoryID.send(nil)
//        }
//    }
//
//    func addNewPassion(_ passion: Passion, to categoryID: PassionCategoryID) {
//        guard var (categories, index) = getCategoryIndex(categoryID) else { return }
//
//        categories[index].passions.append(passion)
//        _categories.send(.success(categories))
//    }
//
//    func addNewRecord(_  record: PassionRecord, to categoryID: PassionCategoryID, and passionID: PassionID) {
//        guard
//            var (categories, categoryIndex) = getCategoryIndex(categoryID),
//            let passionIndex = getPassionIndex(passionID, from: categories[categoryIndex])
//        else {
//            return
//        }
//
//        categories[categoryIndex].passions[passionIndex].records.append(record)
//        _categories.send(.success(categories))
//    }
//}
//
//private extension AppPassionsController {
//    private func getCategoryIndex(
//        _ categoryID: PassionCategoryID
//    ) -> (categories: [PassionCategory], index: Int)? {
//        guard
//            let categories = _categories.value.successOrNil,
//            let categoryIndex: Int = categories.firstIndex(where: { $0.id == categoryID })
//        else {
//            return nil
//        }
//
//        return (categories, categoryIndex)
//    }
//
//    private func getPassionIndex(
//        _ passionID: PassionID,
//        from category: PassionCategory
//    ) -> Int? {
//        guard
//            let passionIndex = category.passions.firstIndex(where: { $0.id == passionID })
//        else {
//            return nil
//        }
//
//        return passionIndex
//    }
//}
