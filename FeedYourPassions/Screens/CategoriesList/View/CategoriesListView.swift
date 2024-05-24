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

    var isInSidebar: Bool
    var uiState: CategoriesListUIState
    var calls: CategoriesListCalls

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
        .animation(.smooth, value: uiState.selectedCategoryType)
        .navigationDestination(isPresented: bindingForScreen(uiState.selectedCategoryType)) {
            if uiState.selectedCategoryType != nil {
                CategoryDetailScreen(viewModel: .init(
                    categoriesController: Container.shared.categoriesController(),
                    categoryDetailController: Container.shared.categoryDetailController()
                ))
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
                } label: {
                    CategoryView(
                        category: category,
                        maxValue: maxValue,
                        color: Color.mGetPaletteColor(.red, forListIndex: index),
                        selected: isInSidebar && uiState.selectedCategoryType == category.type
                    )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        isInSidebar && uiState.selectedCategoryType == category.type
                        ? Color.mAccent
                        : Color.clear
                    )
                }
                .buttonStyle(MPressable())
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
    func bindingForScreen(_ categoryType: PassionCategoryType?) -> Binding<Bool> {
        Binding(
            get: {
                categoryType != nil && uiState.selectedCategoryType == categoryType
            },
            set: { value in
                if value == false {
                    calls.onCategoryTap(nil)
                }
            }
        )
    }
}

#if DEBUG
#Preview("\(CategoriesListView.self)") {
    CategoriesListView(
        isInSidebar: false,
        uiState: .init(
            categories: mockedCategories,
            selectedCategoryType: nil,
            maxValue: 20
        ),
        calls: .init(
            onCategoryTap: { _ in }
        )
    )
}
#endif
