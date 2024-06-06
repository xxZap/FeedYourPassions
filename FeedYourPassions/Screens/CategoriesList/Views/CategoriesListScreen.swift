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

    @State private var settingsViewIsPresented: Bool = false
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        NavigationSplitView(
            columnVisibility: .constant(.doubleColumn),
            sidebar: {
                CategoriesListView(
                    isInSidebar: horizontalSizeClass == .regular,
                    uiState: viewModel.uiState,
                    uiCalls: .init(
                        onCategoryTap: { category in
                            viewModel.setSelectedCategory(category)
                        },
                        onSettingsTap: {
                            settingsViewIsPresented = true
                        }
                    )
                )
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
        .sheet(isPresented: $settingsViewIsPresented, content: {
            SettingsScreen(viewModel: .init())
        })
    }
}
