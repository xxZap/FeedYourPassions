//
//  CategoryDetailView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/04/24.
//

import SwiftUI
import Factory
import Meteor

struct CategoryDetailView: View {

    @StateObject var viewModel: CategoryDetailViewModel

    var body: some View {
        Group {
            switch viewModel.category {
            case .none:
                emptyView
            case .loading:
                loadingView
            case .failure(let error):
                errorView(error)
            case .success(let category):
                passionsList(category.passions)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mBackground)
        .animation(.smooth(duration: AnimationDuration.fast.rawValue), value: viewModel.category?.successOrNil?.passions)
        .navigationTitle(viewModel.category?.successOrNil?.name ?? "Select a category")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func passionsList(_ passions: [OPassion]) -> some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 350))]) {
                    ForEach(passions.indices, id: \.self) { index in
                        let passion = passions[index]
                        PassionView(
                            viewModel: .init(
                                passion: passion,
                                selectedCategoryController: Container.shared.selectedCategoryController()
                            ) { newRecord, passionID in
                                viewModel.createNewRecord(record: newRecord, to: passionID)
                            },
                            barColor: Color.mGetPaletteColor(.pink, forListIndex: index)
                        )
                        .padding(8)
                    }
                    
                    Rectangle()
                        .fill(.clear)
                        .listRowBackground(Color.clear)
                        .frame(height: 1)
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, 8)

            MSideButton(
                onTap: { viewModel.createNewPassion() },
                image: Image(systemName: "plus"),
                side: .attachedToTheRight
            )
            .padding(.bottom, 32)
        }
        .background(Color.mBackground)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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

    private var emptyView: some View {
        VStack {
            Spacer()
            Text("Empty")
            Spacer()
        }
    }
}

#if DEBUG
#Preview("Empty") {
    CategoryDetailView(
        viewModel: .init(selectedCategoryController: MockedSelectedCategory(.empty))
    )
}

#Preview("Error") {
    CategoryDetailView(
        viewModel: .init(selectedCategoryController: MockedSelectedCategory(.error))
    )
}

#Preview("Loading") {
    CategoryDetailView(
        viewModel: .init(selectedCategoryController: MockedSelectedCategory(.loading))
    )
}

#Preview("Valid") {
    CategoryDetailView(
        viewModel: .init(selectedCategoryController: MockedSelectedCategory(.valid(passionsCount: 4)))
    )
}
#endif
