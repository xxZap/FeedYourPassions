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

    init() {
        self._categories = CurrentValueSubject(.loading)
    }

    func fetchGroups() {
        _categories.send(.loading)
        _categories.send(.success(mockedGroups))
    }
}
