//
//  NewPassionScreen.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import SwiftUI

struct NewPassionScreen: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: NewPassionViewModel

    var body: some View {
        NewPassionView(
            uiState: viewModel.uiState,
            calls: .init(
                onEditTitle: { text in
                    viewModel.setTitle(text)
                },
                onSave: {
                    viewModel.save()
                    dismiss()
                },
                onCancel: {
                    dismiss()
                }
            )
        )
    }
}
