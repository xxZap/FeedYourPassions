//
//  GoogleSignInButton.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/06/24.
//

import SwiftUI

struct GoogleSignInButton: View {
    var action: (() -> Void)
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 6) {
                Spacer(minLength: 0)
                Image(.googleLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                Text("Google Sign In")
                    .font(Font.system(size: 18).weight(.semibold))
                    .foregroundStyle(Color.black)
                Spacer(minLength: 0)
            }
            .frame(maxHeight: .infinity)
        }
        .buttonStyle(AppleSignInButtonAlikeStyle())
    }
}

private struct AppleSignInButtonAlikeStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .ignoresSafeArea(.all)
            .background(configuration.isPressed ? Color.gray : Color.white)
    }
}

#if DEBUG
#Preview {
    VStack {
        Spacer()
        GoogleSignInButton {

        }
        Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.gray)
}
#endif
