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

    @Published var uiState: AuthenticationUIState = .init(
        status: .success(false),
        appName: "",
        appVersion: "",
        termsUrlString: "",
        githubUrlString: ""
    )

    private var cancellables = Set<AnyCancellable>()
    @Injected(\.sessionController) private var sessionController
    @Injected(\.externalLinkController) private var externalLinkController

    private var appName: String {
        if let version = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }

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
                let status: AsyncResource<Bool>
                guard let self = self else { return }
                switch asyncUser {
                case .none:
                    status = .success(false)
                case .loading:
                    status = .loading
                case .failure(let error):
                    status = .failure(error)
                case .success:
                    status = .success(true)
                }
                self.uiState = .init(
                    status: status,
                    appName: self.appName,
                    appVersion: self.appVersion,
                    termsUrlString: self.externalLinkController.termsAndConditions,
                    githubUrlString: self.externalLinkController.zapGithubPage
                )
            }
            .store(in: &cancellables)
    }

    func performGoogleSignIn() {
        sessionController.loginWithGoogle()
    }

}
