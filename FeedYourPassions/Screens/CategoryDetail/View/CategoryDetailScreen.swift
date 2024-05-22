//
//  CategoryDetailScreen.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import SwiftUI
import Factory

struct CategoryDetailScreen: View {

    @Environment(\.openURL) private var openURL
    @Environment(\.alerterKey) var alerter
    
    @ObservedObject var viewModel: CategoryDetailViewModel
    @State private var addNewPassion: Bool = false
    @State private var editingPassion: Passion?
    @State private var newName: String?
    @State private var newURL: String?

    var body: some View {
        CategoryDetailView(
            uiState: viewModel.uiState,
            calls: .init(
                onCreatePassionTap: {
                    addNewPassion = true
                },
                onPassionTap: { passion in
                },
                onPassionLaunchTap: { passion, url in
                    openURL(url)
                },
                onPassionAddRecordTap: { passion in

                },
                onPassionEditColorTap: { passion in
                },
                onPassionRenameTap: { passion in
                    editingPassion = passion
                    newName = ""
                },
                onPassionEditURLTap: { passion in
                    editingPassion = passion
                    newURL = passion.associatedURL ?? ""
                }
            )
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.uiState.category?.name ?? "?")
        .onChange(of: viewModel.alert) { old, new in
            alerter.alert = new
        }
        .sheet(isPresented: $addNewPassion) {
            if let category = viewModel.uiState.category {
                NewPassionScreen(
                    viewModel: .init(
                        currentCategory: category,
                        categoryDetailController: Container.shared.categoryDetailController()
                    )
                )
            }
        }
        .alertWithTextField(
            title: "Rename",
            message: "Update the name of the \"\(editingPassion?.name ?? "?")\" passion",
            text: $newName,
            actionTitle: "Confirm",
            actionButtonStyle: .default,
            onAction: { _ in
                guard let passion = editingPassion else { return }
                viewModel.rename(passion: passion, into: newName)
                editingPassion = nil
                newName = nil
            },
            cancelTitle: "Cancel",
            cancelButtonStyle: .cancel,
            onCancelAction: { }
        )
        .alertWithTextField(
            title: "Set an Associated URL",
            message: "Update the URL linked to the \"\(editingPassion?.name ?? "?")\" passion: it is useful to launch external apps or perform a research on the web",
            text: $newURL,
            actionTitle: "Confirm",
            actionButtonStyle: .default,
            onAction: { _ in
                guard let passion = editingPassion else { return }
                viewModel.setAssociatedURL(passion: passion, url: newURL)
                editingPassion = nil
                newURL = nil
            },
            cancelTitle: "Cancel",
            cancelButtonStyle: .cancel,
            onCancelAction: { }
        )
    }
}

#if DEBUG
#Preview("None") {
    CategoryDetailScreen(
        viewModel: .init(
            categoriesController: MockedCategoriesController(.none),
            categoryDetailController: MockedCategoryDetailController(
                .valid(
                    items: [
                        Date(timeIntervalSince1970: 8124698),
                        Date(timeIntervalSince1970: 9124698),
                    ]
                )
            )
        )
    )
}

#Preview("Empty") {
    CategoryDetailScreen(
        viewModel: .init(
            categoriesController: MockedCategoriesController(.empty),
            categoryDetailController: MockedCategoryDetailController(
                .valid(
                    items: [
                        Date(timeIntervalSince1970: 8124698),
                        Date(timeIntervalSince1970: 9124698),
                    ]
                )
            )
        )
    )
}

#Preview("Valid") {
    CategoryDetailScreen(
        viewModel: .init(
            categoriesController: MockedCategoriesController(.valid),
            categoryDetailController: MockedCategoryDetailController(
                .valid(
                    items: [
                        Date(timeIntervalSince1970: 8124698),
                        Date(timeIntervalSince1970: 9124698),
                    ]
                )
            )
        )
    )
}
#endif
