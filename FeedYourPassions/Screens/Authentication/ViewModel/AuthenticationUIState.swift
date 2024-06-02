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
    var appVersion: String
}

struct AuthenticationUICalls {
    var onGoogleSignInTap: (() -> Void)
}
