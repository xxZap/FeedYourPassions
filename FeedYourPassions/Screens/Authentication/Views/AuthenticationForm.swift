//
//  AuthenticationForm.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 05/06/24.
//

import Meteor
import SwiftUI

struct AuthenticationForm: View {

    var appName: String
    var appVersion: String
    var termsUrlString: String
    var githubUrlString: String
    var onGoogleSignInTap: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            logo
            welcomeMessage
            buttons
            MDivider(type: .point)
            termsAndConditions
            MDivider(type: .point)
            footer
        }
        .padding(32)
        .frame(maxWidth: .infinity)
        .background(Color.mBackground)
    }

    private var logo: some View {
        Image(.logoBig)
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(Color.mBackground)
            .aspectRatio(contentMode: .fit)
            .padding(6)
            .frame(height: 58)
            .background(Circle().fill(Color.mAccent))
    }

    private var welcomeMessage: some View {
        Text("Log in to \(appName)")
            .font(.title.weight(.heavy))
            .foregroundStyle(Color.mLightText)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
    }

    private var buttons: some View {
        VStack(spacing: 16) {
            // Google
            GoogleSignInButton {
                onGoogleSignInTap()
            }
            .authenticationButtonStyle()
        }
    }

    private var termsAndConditions: some View {
        let rawText = """
By continuing using this application and its features, you agree to our [Terms and Conditions]($URL).
"""
        let text = rawText.replacingOccurrences(
            of: "$URL",
            with: termsUrlString
        )

        return Text(text.toMarkdown())
            .font(.footnote)
            .foregroundStyle(Color.mLightText)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .tint(Color.mAccent)
    }

    private var footer: some View {
        let rawText = "[ZapIdeas]($URL) | version \(appVersion)"
        let text = rawText.replacingOccurrences(
            of: "$URL",
            with: githubUrlString
        )

        return Text(text.toMarkdown())
            .font(.footnote)
            .foregroundStyle(Color.mAccentDark)
            .tint(Color.mAccent)
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
#Preview {
    VStack(spacing: 0) {
        Spacer()
        AuthenticationForm(
            appName: "Grouap",
            appVersion: "v1.0.0",
            termsUrlString: "",
            githubUrlString: "",
            onGoogleSignInTap: { }
        )
    }.frame(
        maxWidth: .infinity,
        maxHeight: .infinity
    )
}
#endif
