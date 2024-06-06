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
            VStack(spacing: 16) {
                MInfoBox(text: "You are adding a new passion to the \(uiState.category.name) category")
                    .padding(.bottom, 16)

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

                Spacer()
            }
            .padding(16)
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
}

#if DEBUG
#Preview {
    NewPassionView(
        uiState: .init(
            title: "",
            associatedURL: "",
            category: .init(type: .food),
            canBeSaved: true
        ),
        uiCalls: .init(
            onEditTitle: { _ in },
            onEditAssociatedURL: { _ in },
            onSave: { },
            onCancel: { },
            onPassionNameDefinition: { },
            onAssociatedURLDefinition: { }
        )
    )
}
#endif
