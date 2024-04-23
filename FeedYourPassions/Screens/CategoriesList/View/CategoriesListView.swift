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

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            groupList
        }
        .background(Color.mBackground)
        .scrollContentBackground(.hidden)
        .navigationTitle("Feed your passions")
        .toolbarBackground(Color.mBackground, for: .navigationBar)
    }

    private var groupList: some View {
        List {
            ForEach(0 ..< viewModel.categories.count, id: \.self) {
                let category = viewModel.categories[$0]
                CategoryView(
                    category: category,
                    maxValue: viewModel.maxValue,
                    color: Color.mGetColor(forListIndex: $0)
                ) {
                    print("Tapped on group named \"\(category.name)\"")
                }
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
    }
}

#if DEBUG
#Preview("\(CategoriesListView.self)") {
    Group {}
    // ZAPTODO: 
//    CategoryView(viewModel: PassionsViewModel(groups: mockedGroups))
}
#endif
