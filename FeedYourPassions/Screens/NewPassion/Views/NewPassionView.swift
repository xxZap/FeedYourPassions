//
//  NewPassionView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import SwiftUI
import Meteor

struct NewPassionView: View {

    var uiState: NewPassionUIState
    var uiCalls: NewPassionUICalls

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    infoBox
                    passionNameView
                    associatedUrlView
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mBackground)
            .navigationTitle("Add new passion")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        uiCalls.onCancel()
                    } label: {
                        Text("Cancel")
                    }
                    .tint(Color.mAccent)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        uiCalls.onSave()
                    } label: {
                        Text("Add")
                    }
                    .tint(Color.mAccent)
                    .disabled(!uiState.canBeSaved)
                }
            }
        }
    }

    private var infoBox: some View {
        MInfoBox(text: "You are adding a new passion to the \(uiState.category.name) category")
            .padding(.vertical, 16)
    }

    private var passionNameView: some View {
        MTextField(
            text: Binding(
                get: { uiState.title },
                set: { uiCalls.onEditTitle($0) }
            ),
            placeholder: "Passion name",
            title: "Passion name",
            isMandatory: true
        ) {
            uiCalls.onPassionNameDefinition()
        }
    }

    private var associatedUrlView: some View {
        PassionAssociatedUrlView(
            associatedURL: uiState.associatedURL,
            associatedApp: uiState.associatedApp,
            supportedApps: uiState.supportedApplications,
            onEditAssociatedURL: uiCalls.onEditAssociatedURL,
            onEditAssociatedApp: uiCalls.onEditAssociatedApp,
            onAssociatedURLDefinition: uiCalls.onAssociatedURLDefinition,
            onAssociatedAppDefinition: uiCalls.onAssociatedAppDefinition
        )
        .padding(16)
        .background(Color.mBackgroundDark.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#if DEBUG
#Preview {
    NewPassionView(
        uiState: .init(
            title: "",
            associatedURL: "",
            associatedApp: nil,
            category: .init(type: .food),
            canBeSaved: true,
            supportedApplications: [nil]
        ),
        uiCalls: .init(
            onEditTitle: { _ in },
            onEditAssociatedURL: { _ in },
            onEditAssociatedApp: { _ in },
            onSave: { },
            onCancel: { },
            onPassionNameDefinition: { },
            onAssociatedURLDefinition: { },
            onAssociatedAppDefinition: { }
        )
    )
}
#endif

extension MMenuPickerElement {
    init(from supportedApplication: SupportedApplication) {
        let info = supportedApplication.info
        self.init(
            title: info.displayName,
            image: info.image
        )
    }

    func toSupportedApplication() -> SupportedApplication? {
        SupportedApplication.allCases.first { $0.info.displayName == self.title }
    }
}

extension SupportedApplication {
    func toMenuPickerElement() -> MMenuPickerElement {
        MMenuPickerElement(from: self)
    }
}
