//
//  NewPassionView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import SwiftUI
import Meteor

struct NewPassionView: View {

    @Environment(\.alerterKey) var alerter

    var uiState: NewPassionUIState
    var calls: NewPassionCalls

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                MInfoBox(text: "You are adding a new passion to the \(uiState.category.name) category")
                    .padding(.bottom, 16)

                MTextField(
                    text: Binding(
                        get: { uiState.title },
                        set: { calls.onEditTitle($0) }
                    ),
                    placeholder: "Passion name",
                    title: "Passion name",
                    isMandatory: true
                ) {
                    alerter.alert = Alert(
                        title: Text("Passion name"),
                        message: Text("The name of the passion that you'll see inside its category")
                    )
                }

                MTextField(
                    text: Binding(
                        get: { uiState.associatedURL },
                        set: { calls.onEditAssociatedURL($0) }
                    ),
                    placeholder: "Associated URL",
                    title: "Associated URL (optional)",
                    isMandatory: false
                ) {
                    alerter.alert = Alert(
                        title: Text("Associated URL"),
                        message: Text("""
                        If a passion has an associated URL, you'll be able to launch it with a dedicated button:
                        - if the associated URL can open the related App, it will do it.
                        - otherwise it will open Safari as well.
                        """)
                    )
                }

                Spacer()
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mBackground)
            .navigationTitle("Add new passion")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        calls.onCancel()
                    } label: {
                        Text("Cancel")
                    }
                    .tint(Color.mAccent)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        calls.onSave()
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
        calls: .init(
            onEditTitle: { _ in },
            onEditAssociatedURL: { _ in },
            onSave: { },
            onCancel: { }
        )
    )
}
#endif
