//
//  CategoriesListView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI
import Meteor

struct CategoriesListView: View {

    let viewModel: CategoriesListViewModel

    @Binding var selectedItem: OPassionCategory?

    var body: some View {
        Group {
            List(selection: $selectedItem) {
                ForEach(0 ..< viewModel.categories.count, id: \.self) { index in
                    let category = viewModel.categories[index]
                    CategoryView(
                        category: category,
                        maxValue: viewModel.maxValue,
                        color: Color.mGetColor(forListIndex: index)
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

                Rectangle()
                    .fill(.clear)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .frame(height: 100)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .tint(Color.mBackgroundDark)
        }
        .background(Color.mBackground)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#if DEBUG
#Preview("\(CategoriesListView.self)") {
    CategoriesListView(
        viewModel: CategoriesListViewModel(categories: mockedCategories),
        selectedItem: .constant(nil)
    )
}
#endif
