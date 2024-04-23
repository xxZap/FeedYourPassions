//
//  FeedYourPassionsApp.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI
import Combine
import Factory
import Meteor

@main
struct FeedYourPassionsApp: App {

    @ObservedObject private var viewModel = RootViewModel()
    @State var selectedItem: OPassionCategory?

    var body: some Scene {
        WindowGroup {
            GeometryReader { geoProxy in
                NavigationSplitView(
                    columnVisibility: .constant(.doubleColumn),
                    sidebar: {
                        Group {
                            switch viewModel.categories {
                            case .loading:
                                loadingView
                            case .failure(let error):
                                errorView(error)
                            case .success(let categories):
                                CategoriesListView(viewModel: CategoriesListViewModel(categories: categories), selectedItem: $selectedItem)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.mBackground)
                    },
                    detail: {
                        if let selectedItem {
                            CategoryDetailView(viewModel: .init(category: selectedItem))
                        } else {
                            emptyView
                        }
                    }
                )
                .navigationSplitViewStyle(.balanced)
            }
        }
    }

    private var loadingView: some View {
        VStack {
            Spacer()
            MSpinner(size: .large, color: .white)
            Spacer()
        }
    }

    private func errorView(_ error: Error) -> some View {
        VStack {
            Spacer()
            Text(error.localizedDescription)
            Spacer()
        }
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
