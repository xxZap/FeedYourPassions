//
//  UpdatePassionAssociatedUrlView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 09/06/24.
//

import Meteor
import Factory
import SwiftUI
import FirebaseFirestore

private class UpdatePassionAssociatedUrlViewModel: ObservableObject {
    var passionName: String = ""
    @Published var currentURL: String = ""
    @Published var currentApp: SupportedApplication? = nil
    var supportedApplications: [SupportedApplication?] = []

    var currentValue: String {
        currentApp?.info.appUrl ?? currentURL
    }

    @Injected(\.supportedApplicationsController) private var supportedApplicationsController

    init(passion: Passion?) {
        supportedApplications = supportedApplicationsController.supportedApplications

        let passionURL = passion?.associatedURL ?? ""
        let associatedApplication = passionURL.isEmpty
        ? nil
        : supportedApplicationsController.supportedApplications.first(where: {
            passionURL == $0?.info.appUrl
        })

        if let associatedApplication {
            self.currentApp = associatedApplication
        } else {
            self.currentURL = passionURL
        }
    }

    func updateUrl(_ url: String) {
        currentApp = nil
        currentURL = url
    }

    func updateApp(_ app: SupportedApplication?) {
        currentApp = app
        currentURL = ""
    }
}

struct UpdatePassionAssociatedUrlView: View {

    var onCancel: () -> Void
    var onSave: (String) -> Void

    @StateObject private var alerter: Alerter = Alerter()
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel: UpdatePassionAssociatedUrlViewModel

    init(
        passion: Passion?,
        onCancel: @escaping () -> Void,
        onSave: @escaping (String) -> Void
    ) {
        self.onCancel = onCancel
        self.onSave = onSave
        self.viewModel = UpdatePassionAssociatedUrlViewModel(passion: passion)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                MInfoBox(text: "Update the URL linked to the \"\(viewModel.passionName)\" passion: it is useful to launch external apps or perform a research on the web")
                    .padding(.vertical, 16)

                PassionAssociatedUrlView(
                    associatedURL: viewModel.currentURL,
                    associatedApp: viewModel.currentApp,
                    supportedApps: viewModel.supportedApplications,
                    onEditAssociatedURL: viewModel.updateUrl,
                    onEditAssociatedApp: viewModel.updateApp,
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
                .registerAlerter(alerter)
            }
            .padding(16)
            .background(Color.mBackground)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        onCancel()
                    } label: {
                        Text("Cancel")
                    }
                    .tint(Color.mAccent)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onSave(viewModel.currentValue)
                    } label: {
                        Text("Save")
                    }
                    .tint(Color.mAccent)
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    UpdatePassionAssociatedUrlView(
        passion: .init(name: "PassionName", recordsCount: 0, latestUpdate: Timestamp(), color: ""),
        onCancel: { },
        onSave: { _ in }
    )
}
#endif
