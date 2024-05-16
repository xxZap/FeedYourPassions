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
                .alert(isPresented: $alerter.isShowingAlert) {
                    alerter.alert ?? Alert(title: Text(""))
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
                        viewModel.save()
                        dismiss()
                    },
                    onCancel: {
                        dismiss()
                    }
                )
            )
        }
        .environment(\.alerterKey, alerter)
    }
}
