//
//  CategoriesListView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI
import Factory
import Meteor

struct CategoriesListView: View {

    @ObservedObject var viewModel: CategoriesListViewModel

    @Binding var selectedItem: OPassionCategory?

    var body: some View {
        Group {
            switch viewModel.categories {
            case .loading:
                loadingView
            case .failure(let error):
                errorView(error)
            case .success(let categories):
                categoryList(categories)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mBackground)
        .animation(.smooth, value: viewModel.categories)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("List of categories")
    }

    private func categoryList(_ categories: [OPassionCategory]) -> some View {
        List(selection: Binding(
            get: { selectedItem },
            set: {
                viewModel.setSelectedCategory($0?.id)
                selectedItem = $0
            }
        )) {
            ForEach(categories.indices, id: \.self) { index in
                let category = categories[index]
                CategoryView(
                    category: category,
                    maxValue: viewModel.maxValue,
                    color: Color.mGetPaletteColor(.red, forListIndex: index)
                )
                .overlay(
                    NavigationLink(value: category) {
                        EmptyView()
                    }.opacity(0)
                )
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .tint(Color.mBackgroundDark)
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
}

#if DEBUG
#Preview("\(CategoriesListView.self)") {
    CategoriesListView(
        viewModel: CategoriesListViewModel(passionsController: Container.shared.passionsController()),
        selectedItem: .constant(nil)
    )
}
#endif
