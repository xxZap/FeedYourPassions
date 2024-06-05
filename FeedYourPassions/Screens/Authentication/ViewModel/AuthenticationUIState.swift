//
//  AuthenticationUIState.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/06/24.
//

import Foundation
import AuthenticationServices

struct AuthenticationUIState {
    var status: AsyncResource<Bool>
    var appName: String
    var appVersion: String
    var termsUrlString: String
    var githubUrlString: String
}

struct AuthenticationUICalls {
    var onGoogleSignInTap: (() -> Void)
}
