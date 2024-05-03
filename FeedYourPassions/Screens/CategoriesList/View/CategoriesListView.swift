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

    @State private var selectedCategoryID: OPassionCategoryID?

    var body: some View {
        Group {
            switch uiState {
            case .loading:
                loadingView
            case .failure(let error):
                errorView(error)
            case .success(let content):
                categoryList(content)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mBackground)
        .animation(.smooth, value: uiState == .loading)
    }

    private func categoryList(_ content: CategoriesListUIContent) -> some View {
        List {
            ForEach(content.categories.indices, id: \.self) { index in
                let category = content.categories[index]
                Button {
                    calls.onCategoryTap(category)
                    selectedCategoryID = category.id
                } label: {
                    CategoryView(
                        category: category,
                        maxValue: content.maxValue,
                        color: Color.mGetPaletteColor(.red, forListIndex: index)
                    )
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(itemColor(for: category.id))
                }
                .buttonStyle(MPressable())
                .navigationDestination(isPresented: bindingForScreen(category.id)) {
                    CategoryDetailScreen(viewModel: .init(selectedCategoryController: Container.shared.selectedCategoryController()))
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

private extension CategoriesListView {
    func bindingForScreen(_ categoryID: OPassionCategoryID) -> Binding<Bool> {
        Binding(
            get: { selectedCategoryID == categoryID },
            set: { value in
                if value {
                    selectedCategoryID = categoryID
                } else if selectedCategoryID == categoryID {
                    selectedCategoryID = nil
                }
            }
        )
    }

    private func itemColor(for categoryID: OPassionCategoryID) -> Color {
        selectedCategoryID == categoryID ? Color.mBackgroundDark : Color.clear
    }
}

#if DEBUG
#Preview("\(CategoriesListView.self)") {
    CategoriesListView(
        uiState: .success(.init(categories: mockedCategories, maxValue: 20)),
        calls: .init(
            onCategoryTap: { _ in }
        )
    )
}
#endif
