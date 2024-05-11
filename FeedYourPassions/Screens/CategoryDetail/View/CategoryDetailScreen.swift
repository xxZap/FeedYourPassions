//
//  CategoryDetailScreen.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import SwiftUI
import Factory

//struct CategoryDetailScreen: View {
//
//    @StateObject var viewModel: CategoryDetailViewModel
//    @State private var addNewPassion: Bool = false
//
//    var body: some View {
//        CategoryDetailView(
//            uiState: viewModel.uiState,
//            calls: .init(
//                onCreatePassion: {
//                    addNewPassion = true
//                },
//                onAddRecord: { (record, passion) in
//                    viewModel.addNewRecord(record: record, to: passion)
//                }
//            )
//        )
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationTitle(viewModel.uiState?.successOrNil?.category.name ?? "")
//        .sheet(isPresented: $addNewPassion) {
//            NewPassionScreen(viewModel: .init(selectedCategoryController: Container.shared.selectedCategoryController()))
//        }
//    }
//}
//
//#if DEBUG
//#Preview("Empty") {
//    CategoryDetailScreen(
//        viewModel: .init(selectedCategoryController: MockedSelectedCategory(.empty))
//    )
//}
//
//#Preview("Error") {
//    CategoryDetailScreen(
//        viewModel: .init(selectedCategoryController: MockedSelectedCategory(.error))
//    )
//}
//
//#Preview("Loading") {
//    CategoryDetailScreen(
//        viewModel: .init(selectedCategoryController: MockedSelectedCategory(.loading))
//    )
//}
//
//#Preview("Valid") {
//    CategoryDetailScreen(
//        viewModel: .init(selectedCategoryController: MockedSelectedCategory(.valid(passionsCount: 4)))
//    )
//}
//#endif
