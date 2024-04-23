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

    private let _groups: CurrentValueSubject<AsyncResource<[OPassionsGroup]>, Never>
    var groups: AnyPublisher<AsyncResource<[OPassionsGroup]>, Never> {
        _groups.eraseToAnyPublisher()
    }

    init() {
        self._groups = CurrentValueSubject(.loading)
    }

    func fetchGroups() {
        _groups.send(.loading)
        _groups.send(.success(mockedGroups))
    }
}
