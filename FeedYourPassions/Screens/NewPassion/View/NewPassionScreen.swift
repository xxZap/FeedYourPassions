//
//  NewPassionScreen.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import SwiftUI

struct NewPassionScreen: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var alerter: Alerter = Alerter()
    @StateObject var viewModel: NewPassionViewModel

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .alert(isPresented: $alerter.isShowingAlert, appAlert: alerter.alert)
                .onChange(of: viewModel.alert) { old, new in
                    alerter.alert = new
                }

            NewPassionView(
                uiState: viewModel.uiState,
                calls: .init(
                    onEditTitle: { text in
                        viewModel.setTitle(text)
                    },
                    onEditAssociatedURL: { urlString in
                        viewModel.setAssociatedURL(urlString)
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
                    }
                )
            )
        }
        .environment(\.alerterKey, alerter)
    }
}
