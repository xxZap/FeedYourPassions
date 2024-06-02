//
//  AuthenticationViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/06/24.
//

import SwiftUI
import Factory
import Combine

class AuthenticationViewModel: ObservableObject {

    @Published var uiState: AuthenticationUIState = .init(status: .success(false), appVersion: "")

    private var cancellables = Set<AnyCancellable>()
    @Injected(\.sessionController) private var sessionController

    private var appVersion: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return "v\(version)"
        } else {
            return ""
        }
    }

    init() {
        sessionController.loggedUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] asyncUser in
                guard let self = self else { return }
                switch asyncUser {
                case .none:
                    self.uiState = .init(status: .success(false), appVersion: self.appVersion)
                case .loading:
                    self.uiState = .init(status: .loading, appVersion: self.appVersion)
                case .failure(let error):
                    self.uiState = .init(status: .failure(error), appVersion: self.appVersion)
                case .success:
                    self.uiState = .init(status: .success(true), appVersion: self.appVersion)
                }
            }
            .store(in: &cancellables)

    }

    func performGoogleSignIn() {
        sessionController.loginWithGoogle()
    }

}
