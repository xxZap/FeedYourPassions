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
    @State private var addNewPassionIsPresented: Bool = false
    @State private var passionColorPickerIsPresented: Bool = false
    @State private var passionAssociatedUrlIsPresented: Bool = false
    @State private var editingPassion: Passion?
    @State private var editingColor: Color = Color.mBackgroundDark
    @State private var newName: String?

    var body: some View {
        CategoryDetailView(
            uiState: viewModel.uiState,
            uiCalls: .init(
                onCreatePassionTap: {
                    addNewPassionIsPresented = true
                },
                onPassionTap: { passion in
                },
                onPassionLaunchTap: { passion, url in
                    openURL(url)
                },
                onPassionAddRecordTap: { passion in
                    viewModel.addNewRecord(for: Date(), to: passion)
                },
                onPassionEditColorTap: { passion in
                    editingPassion = passion
                    editingColor = Color(hex: passion.color) ?? Color.mBackgroundDark
                    passionColorPickerIsPresented = true
                },
                onPassionRenameTap: { passion in
                    editingPassion = passion
                    newName = ""
                },
                onPassionEditURLTap: { passion in
                    editingPassion = passion
                    passionAssociatedUrlIsPresented = true
                },
                onPassionDeleteTap: { passion in
                    viewModel.delete(passion: passion)
                }
            )
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.uiState.title)
        .onChange(of: viewModel.alert) { old, new in
            alerter.alert = new
        }
        .sheet(isPresented: $addNewPassionIsPresented) {
            if let category = viewModel.uiState.category {
                NewPassionScreen(
                    viewModel: .init(currentCategory: category.passionCategory)
                )
            }
        }
        .sheet(
            isPresented: $passionColorPickerIsPresented,
            onDismiss: {
                editingPassion = nil
            }
        ) {
            PassionColorPickerView(selectedColor: editingColor) { color in
                if let editingPassion, let hexColorString = color.toHex() {
                    viewModel.setColor(hexColorString, to: editingPassion)
                }
                passionColorPickerIsPresented = false
            }
        }
        .sheet(
            isPresented: $passionAssociatedUrlIsPresented,
            onDismiss: {
                editingPassion = nil
            }
        ) {
            UpdatePassionAssociatedUrlView(
                passion: editingPassion,
                onCancel: {
                    editingPassion = nil
                    passionAssociatedUrlIsPresented = false
                }, 
                onSave: { url in
                    passionAssociatedUrlIsPresented = false
                    guard let passion = editingPassion else { return }
                    viewModel.setAssociatedURL(url, to: passion)
                    editingPassion = nil
                }
            )
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
    }
}

#if DEBUG
#Preview("None") {
    let _ = Container.shared.categoriesController.register {
        MockedCategoriesController(.none)
    }
    let _ = Container.shared.categoryDetailController.register {
        MockedCategoryDetailController(
            .failure
       )
    }
    return CategoryDetailScreen(viewModel: .init())
}

#Preview("Empty") {
    let _ = Container.shared.categoriesController.register {
        MockedCategoriesController(.empty)
    }
    let _ = Container.shared.categoryDetailController.register {
        MockedCategoryDetailController(
           .empty
       )
    }
    return CategoryDetailScreen(viewModel: .init())
}

#Preview("Valid") {
    let _ = Container.shared.categoriesController.register {
        MockedCategoriesController(.valid(categories: mockedCategories))
    }
    let _ = Container.shared.categoryDetailController.register {
        MockedCategoryDetailController(
           .valid(
               items: [
                   Date(timeIntervalSince1970: 8124698),
                   Date(timeIntervalSince1970: 9124698),
               ]
           )
       )
    }
    return CategoryDetailScreen(viewModel: .init())
}
#endif
