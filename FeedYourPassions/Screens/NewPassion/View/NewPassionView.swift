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
    var calls: NewPassionCalls

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                MTextField(
                    text: Binding(
                        get: { uiState.title },
                        set: { calls.onEditTitle($0) }
                    ),
                    placeholder: "Passion name",
                    title: "Passion name",
                    isMandatory: true
                )

                MTextField(
                    text: Binding(
                        get: { uiState.title },
                        set: { calls.onEditTitle($0) }
                    ),
                    placeholder: "Associated URL",
                    title: "Associated URL (optional)",
                    isMandatory: false
                )

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
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    NewPassionView(
        uiState: .init(title: "", associatedURL: nil),
        calls: .init(
            onEditTitle: { _ in },
            onSave: { },
            onCancel: { }
        )
    )
}
#endif
