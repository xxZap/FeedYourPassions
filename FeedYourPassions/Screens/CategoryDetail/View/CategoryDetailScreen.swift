//
//  CategoryDetailScreen.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import SwiftUI
import Factory

struct CategoryDetailScreen: View {

    @ObservedObject var viewModel: CategoryDetailViewModel
    @State private var addNewPassion: Bool = false

    var body: some View {
        CategoryDetailView(
            uiState: viewModel.uiState,
            calls: .init(
                onCreatePassionTap: {
                    addNewPassion = true
                }
//                onAddRecord: { (record, passion) in
//                    viewModel.addNewRecord(record: record, to: passion)
//                }
            )
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.uiState.category?.name ?? "")
        .sheet(isPresented: $addNewPassion) {
            if let category = viewModel.uiState.category {
                NewPassionScreen(
                    viewModel: .init(
                        currentCategory: category,
                        categoriesController: Container.shared.categoriesController()
                    )
                )
            }
        }
    }
}

#if DEBUG
#Preview("None") {
    CategoryDetailScreen(
        viewModel: .init(
            category: PassionCategory(type: .family),
            categoriesController: MockedCategoriesController(.none), 
            categoryDetailController: MockedCategoryDetailController(.valid(count: 2))
        )
    )
}

#Preview("Empty") {
    CategoryDetailScreen(
        viewModel: .init(
            category: PassionCategory(type: .family),
            categoriesController: MockedCategoriesController(.empty),
            categoryDetailController: MockedCategoryDetailController(.valid(count: 2))
        )
    )
}

#Preview("Valid") {
    CategoryDetailScreen(
        viewModel: .init(
            category: PassionCategory(type: .family),
            categoriesController: MockedCategoriesController(.valid),
            categoryDetailController: MockedCategoryDetailController(.valid(count: 2))
        )
    )
}
#endif
