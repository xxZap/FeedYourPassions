//
//  AuthenticationView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/06/24.
//

import Meteor
import SwiftUI

struct AuthenticationView: View {

    let uiState: AuthenticationUIState
    let uiCalls: AuthenticationUICalls

    @State private var shown: Bool = false
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        VStack(spacing: 0) {
            if horizontalSizeClass == .regular {
                Spacer()
                    .frame(maxHeight: .infinity)
            }

            textualLogo
                .frame(maxHeight: .infinity)

            AuthenticationForm(
                appName: uiState.appName,
                appVersion: uiState.appVersion,
                termsUrlString: uiState.termsUrlString,
                githubUrlString: uiState.githubUrlString,
                onGoogleSignInTap: uiCalls.onGoogleSignInTap
            )
            .frame(
                maxWidth: horizontalSizeClass == .regular ? 400 : nil
            )
            .clipShape(.rect(
                topLeadingRadius: 16,
                bottomLeadingRadius: horizontalSizeClass == .regular ? 16 : 0,
                bottomTrailingRadius: horizontalSizeClass == .regular ? 16 : 0,
                topTrailingRadius: 16
            ))

            if horizontalSizeClass == .regular {
                Spacer()
                    .frame(maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
        .background(Color.mBackgroundDark)
        .onAppear {
            shown = true
        }
    }

    private var textualLogo: some View {
        Image(.logoTextualBig)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250)
            .opacity(shown ? 1 : 0)
            .animation(.smooth(duration: 2).delay(1), value: shown)
    }
}

#if DEBUG
#Preview("Idle") {
    AuthenticationView(
        uiState: .init(
            status: .success(false),
            appName: "Grouap",
            appVersion: "v1.0.0",
            termsUrlString: "",
            githubUrlString: ""
        ),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}

#Preview("Success") {
    AuthenticationView(
        uiState: .init(
            status: .success(true),
            appName: "Grouap",
            appVersion: "v1.0.0",
            termsUrlString: "",
            githubUrlString: ""
        ),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}

#Preview("Loading") {
    AuthenticationView(
        uiState: .init(
            status: .loading,
            appName: "Grouap",
            appVersion: "v1.0.0",
            termsUrlString: "",
            githubUrlString: ""
        ),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}

#Preview("Failure") {
    AuthenticationView(
        uiState: .init(
            status: .failure(NSError()),
            appName: "Grouap",
            appVersion: "v1.0.0",
            termsUrlString: "",
            githubUrlString: ""
        ),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}
#endif
