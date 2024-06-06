//
//  SettingsView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 05/06/24.
//

import Meteor
import SwiftUI

struct SettingsView: View {

    let uiState: SettingsUIState
    let uiCalls: SettingsUICalls

    var body: some View {
        ZStack {
            Color.mBackground
                .ignoresSafeArea()

            switch uiState {
            case .loading:
                loadingView
            case .failure:
                EmptyView()
            case .success(let content):
                menu(for: content)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    uiCalls.onDismissTap()
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(Color.mAccent)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Settings")
    }

    private var loadingView: some View {
        VStack(spacing: 8) {
            Spacer()
            MSpinner(size: .large, color: .accent)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }

    private func menu(for content: SettingsUIContent) -> some View {
        MList {
            header(name: content.username, email: content.email)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)

            MSection {
                MListItem(
                    text: "Terms and conditions",
                    icon: Image(systemName: "chevron.right")
                ) {
                    uiCalls.onOpenTermsTap()
                }

                MListItem(
                    text: "Grouap Github page",
                    icon: Image(systemName: "chevron.right")
                ) {
                    uiCalls.onOpenGithubTap()
                }
            }

            MSection {
                MListItem(
                    text: "Logout",
                    icon: Image(systemName: "rectangle.portrait.and.arrow.right"),
                    iconColor: Color.mDangerText
                ) {
                    uiCalls.onLogoutTap()
                }
            }
        }
    }

    private func header(
        name: String,
        email: String
    ) -> some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                Text(name)
                    .font(.title)
                    .foregroundStyle(Color.mLightText)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                Text(email)
                    .font(.subheadline)
                    .foregroundStyle(Color.mMediumText)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#if DEBUG
#Preview("loading") {
    SettingsView(
        uiState: .loading,
        uiCalls: .init(
            onDismissTap: { },
            onOpenTermsTap: { },
            onOpenGithubTap: { },
            onLogoutTap: { }
        )
    )
}

#Preview("success") {
    SettingsView(
        uiState: .success(
            .init(
                username: "Mario Rossi",
                email: "mario.rossi.test@grouap.it"
            )
        ),
        uiCalls: .init(
            onDismissTap: { },
            onOpenTermsTap: { },
            onOpenGithubTap: { },
            onLogoutTap: { }
        )
    )
}

#Preview("failure") {
    SettingsView(
        uiState: .failure(NSError()),
        uiCalls: .init(
            onDismissTap: { },
            onOpenTermsTap: { },
            onOpenGithubTap: { },
            onLogoutTap: { }
        )
    )
}
#endif
