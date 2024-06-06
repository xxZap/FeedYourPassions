//
//  SettingsScreen.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 05/06/24.
//

import SwiftUI

struct SettingsScreen: View {

    var viewModel: SettingsViewModel

    @StateObject private var alerter: Alerter = Alerter()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationStack {
            SettingsView(
                uiState: viewModel.uiState,
                uiCalls: .init(
                    onDismissTap: {
                        dismiss()
                    },
                    onOpenTermsTap: {
                        if let url = ExternalLinkProvider.termsAndConditions.url {
                            openURL(url)
                        }
                    },
                    onOpenGithubTap: {
                        if let url = ExternalLinkProvider.xxZapGithub.url {
                            openURL(url)
                        }
                    },
                    onLogoutTap: {
                        alerter.alert = AppAlert.Confirmation.logout { confirmed in
                            if confirmed {
                                viewModel.logout()
                            }
                        }
                    }
                )
            )
            .registerAlerter(alerter)
        }
        .navigationBarTitleDisplayMode(.inline)
        .tint(Color.mLightText)
    }
}
