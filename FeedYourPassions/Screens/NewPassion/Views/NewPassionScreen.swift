//
//  NewPassionScreen.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import SwiftUI

struct NewPassionScreen: View {

    @StateObject var viewModel: NewPassionViewModel

    @Environment(\.dismiss) private var dismiss
    @StateObject private var alerter: Alerter = Alerter()

    var body: some View {
        NewPassionView(
            uiState: viewModel.uiState,
            uiCalls: .init(
                onEditTitle: { text in
                    viewModel.setTitle(text)
                },
                onEditAssociatedURL: { urlString in
                    viewModel.setAssociatedURL(urlString)
                },
                onEditAssociatedApp: { supportedApp in
                    viewModel.setAssociatedApp(supportedApp)
                },
                onSave: {
                    if viewModel.save() {
                        dismiss()
                    }
                },
                onCancel: {
                    dismiss()
                },
                onPassionNameDefinition: {
                    alerter.alert = AppAlert.Definition.PassionName(onDismiss: {
                        alerter.alert = nil
                    })
                },
                onAssociatedURLDefinition: {
                    alerter.alert = AppAlert.Definition.AssociatedURL(onDismiss: {
                        alerter.alert = nil
                    })
                },
                onAssociatedAppDefinition: {
                    alerter.alert = AppAlert.Definition.AssociatedApp(onDismiss: {
                        alerter.alert = nil
                    })
                }
            )
        )
        .registerAlerter(alerter)
        .onChange(of: viewModel.alert) { old, new in
            alerter.alert = new
        }
    }
}
