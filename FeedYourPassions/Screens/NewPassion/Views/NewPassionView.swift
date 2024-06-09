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
        VStack(alignment: .center, spacing: 8) {
            MTextField(
                text: Binding(
                    get: { uiState.associatedURL },
                    set: { uiCalls.onEditAssociatedURL($0) }
                ),
                placeholder: "Associated URL",
                title: "Associated URL (optional)",
                isMandatory: false
            ) {
                uiCalls.onAssociatedURLDefinition()
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.none)
            
            MDivider(type: .string("OR"))
            
            MMenuPicker(
                selectedElement: Binding(
                    get: { uiState.associatedApp?.toMenuPickerElement() },
                    set: { uiCalls.onEditAssociatedApp($0?.toSupportedApplication()) }
                ),
                elements: uiState.supportedApplications.map { $0?.toMenuPickerElement() },
                title: "Associated APP (optional)",
                isMandatory: false
            ) {
                uiCalls.onAssociatedAppDefinition()
            }
        }
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
