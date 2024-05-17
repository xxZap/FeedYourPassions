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
            AppSelectedCategoryController()
        }.singleton
    }
}

class AppSelectedCategoryController: SelectedCategoryController {

    private let _selectedCategory: CurrentValueSubject<PassionCategory?, Never>
    var selectedCategory: AnyPublisher<PassionCategory?, Never> {
        _selectedCategory.eraseToAnyPublisher()
    }

    var maxValue: Int {
        _selectedCategory.value?.maxValue ?? 0
    }

    private var cancellables = Set<AnyCancellable>()

    init() {
        self._selectedCategory = CurrentValueSubject(nil)
    }

    func addNewPassion(_ passion: Passion) {

    }
}

#if DEBUG
class MockedSelectedCategory: SelectedCategoryController {

    enum Scenario {
        case empty
        case valid(passionsCount: Int)
    }

    private let _category: CurrentValueSubject<PassionCategory?, Never>
    var selectedCategory: AnyPublisher<PassionCategory?, Never> { _category.eraseToAnyPublisher() }

    var maxValue: Int

    init(_ scenario: Scenario) {
        switch scenario {
        case .empty:
            maxValue = 0
            _category = CurrentValueSubject(nil)
        case .valid(let count):
            maxValue = 0
            _category = CurrentValueSubject(.init(type: .family, passions: (0..<count).map { Passion(name: "#\($0) Passion", associatedURL: "some", records: []) }))
        }
    }

    func addNewPassion(_ passion: Passion) {

    }
}
#endif
