//
//  CategoriesListViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation
import Combine

class CategoriesListViewModel {

    @Published var categories: AsyncResource<[OPassionCategory]> = .loading
    var maxValue: Int { categories.successOrNil?.map { $0.currentValue }.max() ?? 0 }

    private var cancellables = Set<AnyCancellable>()

    init(passionsController: PassionsController) {
        passionsController.categories
            .sink { [weak self] categories in
                self?.categories = categories.map { $0.sorted(by: { $0.currentValue > $1.currentValue }) }
            }
            .store(in: &cancellables)

        passionsController.fetchGroups()
    }
}
