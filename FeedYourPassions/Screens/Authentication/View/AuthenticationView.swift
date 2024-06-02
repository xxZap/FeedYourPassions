//
//  AuthenticationView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/06/24.
//

import Meteor
import SwiftUI

struct AuthenticationView: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let uiState: AuthenticationUIState
    let uiCalls: AuthenticationUICalls

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            header
            buttons
            Spacer()
            footer
        }
        .frame(
            maxWidth: horizontalSizeClass == .regular ? 392 : .infinity,
            maxHeight: .infinity
        )
        .padding(.horizontal, 16)
    }

    private var header: some View {
        VStack(spacing: 16) {
            HStack(spacing: 4) {
//                Image(.assistant)
//                    .resizable()
//                    .frame(width: 36, height: 36)
//                Image(.italia)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 36)
                Spacer(minLength: 0)
            }

            Text("Welcome message")
                .font(.callout)
                .foregroundStyle(Color.mLightText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .padding(.bottom, 8)
    }

    private var buttons: some View {
        VStack(spacing: 16) {
            // Google
            GoogleSignInButton(
                action: uiCalls.onGoogleSignInTap
            )
            .authenticationButtonStyle()
        }
    }

    private var footer: some View {
        VStack(alignment: .center, spacing: 4) {
            HStack(alignment: .center, spacing: 8) {
                Link(
                    destination: URL(string: "https://github.com/xxZap")!,
                    label: {
                        Text("ZapIdeas")
                            .underline(false)
                            .tint(.mAccent)
                            .font(.body)
                            .frame(minHeight: 22)
                    }
                )
                Divider()
                Text(uiState.appVersion)
                    .font(.body)
                    .foregroundStyle(Color.mLightText)
            }
            .fixedSize()
        }
        .padding(.bottom, 8)
    }
}

private extension View {
    func authenticationButtonStyle() -> some View {
        self
            .frame(height: 48)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.mBorder, lineWidth: 1)
            }
    }
}

#if DEBUG
#Preview("Idle") {
    AuthenticationView(
        uiState: .init(status: .success(false), appVersion: "v. 1.0.0"),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}

#Preview("Success") {
    AuthenticationView(
        uiState: .init(status: .success(true), appVersion: "v. 1.0.0"),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}

#Preview("Loading") {
    AuthenticationView(
        uiState: .init(status: .loading, appVersion: "v. 1.0.0"),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}

#Preview("Failure") {
    AuthenticationView(
        uiState: .init(status: .failure(NSError()), appVersion: "v. 1.0.0"),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}
#endif
