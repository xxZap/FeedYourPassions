//
//  AuthenticationScreen.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/06/24.
//

import SwiftUI

struct AuthenticationScreen: View {

    @StateObject var viewModel: AuthenticationViewModel

    var body: some View {
        AuthenticationView(
            uiState: viewModel.uiState,
            uiCalls: .init(
                onGoogleSignInTap: {
                    viewModel.performGoogleSignIn()
                }
            )
        )
    }
}
