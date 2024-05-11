//
//  AppSelectedCategoryController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 26/04/24.
//

import Foundation
import Combine
import Factory

//extension Container {
//    var selectedCategoryController: Factory<SelectedCategoryController> {
//        Factory(self) {
//            AppSelectedCategoryController(passionsController: Container.shared.passionsController())
//        }.singleton
//    }
//}
//
//class AppSelectedCategoryController: SelectedCategoryController {
//
//    private let _selectedCategory: CurrentValueSubject<AsyncResource<PassionCategory>?, Never>
//    var selectedCategory: AnyPublisher<AsyncResource<PassionCategory>?, Never> {
//        _selectedCategory.eraseToAnyPublisher()
//    }
//
//    var maxValue: Int {
//        _selectedCategory.value?.successOrNil?.maxValue ?? 0
//    }
//
//    private let passionsController: PassionsController
//    private var cancellables = Set<AnyCancellable>()
//
//    init(passionsController: PassionsController) {
//        self.passionsController = passionsController
//        self._selectedCategory = CurrentValueSubject(.loading)
//
//        passionsController.categories
//            .combineLatest(passionsController.selectedCategoryID)
//            .receive(on: DispatchQueue.main )
//            .sink { asyncCategories, asyncSelectedCategoryID in
//                _ = asyncCategories.asyncMap { [weak self] categories in
//                    if let asyncSelectedCategoryID = asyncSelectedCategoryID {
//                        _ = asyncSelectedCategoryID.asyncMap { [weak self] selectedCategoryID in
//                            guard let category = categories.first(where: { $0.id == selectedCategoryID }) else {
//                                self?._selectedCategory.send(.failure(NSError()))
//                                return
//                            }
//                            self?._selectedCategory.send(.success(category))
//                        }
//                    } else {
//                        self?._selectedCategory.send(nil)
//                    }
//                }
//            }
//            .store(in: &cancellables)
//    }
//
//    func addNewPassion(_ passion: Passion) {
//        guard let selectedCategoryID = _selectedCategory.value?.successOrNil?.id else { return }
//        passionsController.addNewPassion(passion, to: selectedCategoryID)
//    }
//
//    func addNewRecord(_ record: PassionRecord, to passionID: PassionID) {
//        guard let selectedCategoryID = _selectedCategory.value?.successOrNil?.id else { return }
//        passionsController.addNewRecord(record, to: selectedCategoryID, and: passionID)
//    }
//}
//
//#if DEBUG
//class MockedSelectedCategory: SelectedCategoryController {
//
//    enum Scenario {
//        case loading
//        case empty
//        case valid(passionsCount: Int)
//        case error
//    }
//
//    private let _category: CurrentValueSubject<AsyncResource<PassionCategory>?, Never>
//    var selectedCategory: AnyPublisher<AsyncResource<PassionCategory>?, Never> { _category.eraseToAnyPublisher() }
//
//    var maxValue: Int
//
//    init(_ scenario: Scenario) {
//        switch scenario {
//        case .loading:
//            maxValue = 0
//            _category = CurrentValueSubject(.loading)
//        case .empty:
//            maxValue = 0
//            _category = CurrentValueSubject(nil)
//        case .valid(let count):
//            maxValue = 0
//            _category = CurrentValueSubject(.success(.init(name: "Passion", passions: (0..<count).map { Passion(name: "#\($0) Passion", associatedURL: "some", records: [])})))
//        case .error:
//            maxValue = 0
//            _category = CurrentValueSubject(.failure(NSError()))
//        }
//    }
//
//    func addNewPassion(_ passion: Passion) {
//
//    }
//    
//    func addNewRecord(_ record: PassionRecord, to passionID: PassionID) {
//
//    }
//}
//#endif
