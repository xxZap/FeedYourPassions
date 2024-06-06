//
//  SettingsViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 05/06/24.
//

import SwiftUI
import Factory
import Combine
import FirebaseAuth

class SettingsViewModel: ObservableObject {

    @Published var uiState: SettingsUIState

    private var cancellables = Set<AnyCancellable>()

    @Injected(\.sessionController) private var sessionController

    init() {
        uiState = .loading
        sessionController.loggedUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                _ = user?.asyncMap { [weak self] user in
                    guard let self = self else { return }

                    self.uiState = .success(
                        .init(
                            username: user.displayName ?? "",
                            email: user.email ?? ""
                        )
                    )
                }
            }
            .store(in: &cancellables)
    }

    func logout() {
        sessionController.logout()
    }
}
