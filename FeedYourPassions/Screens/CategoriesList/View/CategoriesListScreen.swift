//
//  CategoriesListScreen.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 03/05/24.
//

import SwiftUI
import Meteor

struct CategoriesListScreen: View {

    @Environment(\.alerterKey) var alerter
    @ObservedObject var viewModel: CategoriesListViewModel

    var body: some View {
        NavigationSplitView(
            columnVisibility: .constant(.doubleColumn),
            sidebar: {
                CategoriesListView(
                    uiState: viewModel.uiState,
                    calls: .init(
                        onCategoryTap: { category in

                        }
                    )
                )
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(removing: .sidebarToggle)
            },
            detail: {
//                if selectedItem == nil {
//                    emptyView
//                        .navigationBarTitleDisplayMode(.inline)
//                } else {
//                    CategoryDetailScreen(viewModel: .init(selectedCategoryController: Container.shared.selectedCategoryController()))
//                        .navigationBarTitleDisplayMode(.inline)
//                }
            }
        )
        .navigationSplitViewStyle(.balanced)
        .navigationBarTitleDisplayMode(.inline)
        .environment(\.alerterKey, alerter)
        .tint(Color.mLightText)
    }

    private var emptyView: some View {
        ZStack {
            Color.mBackground
                .ignoresSafeArea()

            Text("Choose one option on the left")
                .font(.subheadline)
                .foregroundStyle(Color.mLightText)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
    }
}
