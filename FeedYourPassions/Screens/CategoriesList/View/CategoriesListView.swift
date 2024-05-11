//
//  CategoriesListView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI
import Meteor
import Factory

struct CategoriesListView: View {

    var uiState: CategoriesListUIState
    var calls: CategoriesListCalls

    @State private var selectedCategoryType: PassionCategoryType?

    var body: some View {
        Group {
            if let categories = uiState.categories {
                if categories.isEmpty {
                    emptyView
                } else {
                    categoryList(categories, maxValue: uiState.maxValue)
                }
            } else {
                loadingView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mBackground)
        .animation(.smooth, value: uiState.categories)
    }

    private var loadingView: some View {
        VStack {
            Spacer()
            MSpinner(size: .large, color: .white)
            Spacer()
        }
    }

    private var emptyView: some View {
        VStack {
            Spacer()
            Text("Empty")
            Spacer()
        }
    }

    private func categoryList(_ categories: [PassionCategory], maxValue: Int) -> some View {
        List {
            ForEach(Array(categories.enumerated()), id: \.element) { index, category in
                Button {
                    calls.onCategoryTap(category)
                    selectedCategoryType = category.type
                } label: {
                    CategoryView(
                        category: category,
                        maxValue: maxValue,
                        color: Color.mGetPaletteColor(.red, forListIndex: index)
                    )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(selectedCategoryType == category.type ? Color.mBackgroundDark : Color.clear)
                }
                .buttonStyle(MPressable())
                .navigationDestination(isPresented: bindingForScreen(category.type)) {
                    if selectedCategoryType == category.type {
                        CategoryDetailScreen(viewModel: .init(
                            category: category,
                            dataController: Container.shared.dataController()
                        ))
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .tint(Color.mBackgroundDark)
    }
}

private extension CategoriesListView {
    func bindingForScreen(_ categoryType: PassionCategoryType) -> Binding<Bool> {
        Binding(
            get: { selectedCategoryType == categoryType },
            set: { value in
                if value {
                    selectedCategoryType = categoryType
                } else if selectedCategoryType == categoryType {
                    selectedCategoryType = nil
                }
            }
        )
    }
}

#if DEBUG
#Preview("\(CategoriesListView.self)") {
    CategoriesListView(
        uiState: .init(categories: mockedCategories, maxValue: 20),
        calls: .init(
            onCategoryTap: { _ in }
        )
    )
}
#endif
