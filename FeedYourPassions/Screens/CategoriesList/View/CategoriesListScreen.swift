//
//  CategoriesListScreen.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 03/05/24.
//

import SwiftUI
import Meteor

struct CategoriesListScreen: View {

    @StateObject var viewModel: CategoriesListViewModel

    var body: some View {
        NavigationSplitView(
            columnVisibility: .constant(.doubleColumn),
            sidebar: {
                CategoriesListView(
                    uiState: viewModel.uiState,
                    calls: .init(
                        onCategoryTap: { category in
                            viewModel.setSelectedCategory(category.id)
                        }
                    )
                )
                .toolbar(removing: .sidebarToggle)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Home")
            },
            detail: {
                ZStack {
                    Color.mBackground
                        .ignoresSafeArea()

                    Text("Choose one option on the left")
                        .font(.subheadline)
                        .foregroundStyle(Color.mLightText)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        )
        .navigationSplitViewStyle(.balanced)
        .navigationBarTitleDisplayMode(.inline)
        .tint(Color.mLightText)
    }
}
