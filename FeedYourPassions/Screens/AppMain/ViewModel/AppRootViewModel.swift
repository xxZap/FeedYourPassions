//
//  AppRootViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/06/24.
//

import SwiftUI
import Combine
import Factory

class AppRootViewModel: ObservableObject {

    @Published var uiState: AppRootUIState

    private var cancellables = Set<AnyCancellable>()

    @Injected(\.sessionController) private var sessionController
    @Injected(\.categoriesController) private var categoriesController

    init() {
        uiState = .init(user: .loading)

        sessionController.loggedUser
            .combineLatest(categoriesController.categories)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] asyncUser, categories in
                switch asyncUser {
                case .none:
                    self?.uiState = .init(user: nil)
                case .loading:
                    self?.uiState = .init(user: .loading)
                case .failure(let error):
                    self?.uiState = .init(user: .failure(error))
                    self?.sessionController.logout()
                case .success(let user):
                    switch categories {
                    case .none:
                        self?.categoriesController.fetchCategories()
                    case .success:
                        self?.uiState = .init(user: .success(user))
                    case .loading:
                        self?.uiState = .init(user: .loading)
                    case .failure(let error):
                        self?.uiState = .init(user: .failure(error))
                        self?.sessionController.logout()
                    }
                }
            }
            .store(in: &cancellables)
    }

    func restoreSession() {
        sessionController.restoreSession()
    }
}
