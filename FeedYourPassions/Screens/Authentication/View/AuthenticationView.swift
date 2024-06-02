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

    @State private var shown: Bool = false

    var body: some View {
        GeometryReader { geoProxy in
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Spacer(minLength: 0)
                    logo
                    Spacer(minLength: 0)
                }
                .frame(height: geoProxy.size.height * 0.5)

                Spacer()

                VStack(alignment: .center, spacing: 16) {
                    Spacer()
                    header
                    buttons

                    footerDivider

                    footer
                    Spacer()
                }
                .padding(.horizontal, 24)
                .frame(
                    maxWidth: horizontalSizeClass == .regular ? 392 : .infinity,
                    maxHeight: horizontalSizeClass == .regular ? 392 : .infinity
                )
                .background(Color.mBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                Spacer()
            }
            .ignoresSafeArea()
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(Color.mBackgroundDark)
            .onAppear {
                shown = true
            }
        }
    }

    private var logo: some View {
        Image(.logoBig)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 160)
            .padding(.top, 100)
            .opacity(shown ? 1 : 0)
            .animation(.smooth(duration: 2).delay(1), value: shown)
    }

    private var header: some View {
        Text("Sign In")
            .font(.title.weight(.heavy))
            .foregroundStyle(Color.mLightText)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .padding(.vertical, 24)
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

    private var footerDivider: some View {
        HStack(spacing: 16) {
            Rectangle()
                .fill(Color.mAccentDark)
                .frame(height: 2)
                .frame(maxWidth: 60)
                .clipShape(Capsule())

            Circle()
                .fill(Color.mLightText)
                .frame(width: 4, height: 4)

            Rectangle()
                .fill(Color.mAccentDark)
                .frame(height: 2)
                .frame(maxWidth: 60)
                .clipShape(Capsule())
        }
    }

    private var footer: some View {
        GeometryReader { geoProxy in
            HStack(alignment: .center, spacing: 36) {
                Link(
                    destination: URL(string: "https://github.com/xxZap")!,
                    label: {
                        Text("ZapIdeas")
                            .font(.footnote)
                            .foregroundStyle(Color.mAccent)
                            .frame(maxWidth: geoProxy.size.width * 0.5, alignment: .trailing)
                            .underline(false)
                    }
                )
                Text(uiState.appVersion)
                    .font(.footnote)
                    .foregroundStyle(Color.mAccentDark)
                    .frame(maxWidth: geoProxy.size.width * 0.5, alignment: .leading)
            }
        }
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
        uiState: .init(status: .success(false), appVersion: "v1.0.0"),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}

#Preview("Success") {
    AuthenticationView(
        uiState: .init(status: .success(true), appVersion: "v1.0.0"),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}

#Preview("Loading") {
    AuthenticationView(
        uiState: .init(status: .loading, appVersion: "v1.0.0"),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}

#Preview("Failure") {
    AuthenticationView(
        uiState: .init(status: .failure(NSError()), appVersion: "v1.0.0"),
        uiCalls: .init(
            onGoogleSignInTap: { }
        )
    )
}
#endif
