//
//  RootViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/04/24.
//

import Foundation
import Combine
import Factory

class RootViewModel: ObservableObject {

    @Published var categories: AsyncResource<[OPassionCategory]>

    private var cancellables = Set<AnyCancellable>()

    init() {
        self.categories = .loading

        let passionsController = Container.shared.passionsController()

        passionsController.categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.categories = categories
            }
            .store(in: &cancellables)

        passionsController.fetchGroups()
    }
}
