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

    var uiState: CategoryDetailUIState?
    var calls: CategoryDetailCalls

    var body: some View {
        Group {
            switch uiState {
            case .none:
                emptyView
            case .loading:
                loadingView
            case .failure(let error):
                errorView(error)
            case .success(let content):
                passionsList(content.category.passions)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mBackground)
        .animation(.smooth(duration: MAnimationDuration.fast.rawValue), value: uiState)
        .navigationTitle(uiState?.successOrNil?.category.name ?? "Select a category")
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
                                calls.onAddRecord((newRecord, passionID))
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
                onTap: {
                    calls.onCreatePassion()
                },
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
#Preview {
    CategoryDetailView(
        uiState: .success(.init(category: OPassionCategory(
            name: "Category",
            passions: [OPassion(name: "Passion name", records: [])]
        ))),
        calls: .init(
            onCreatePassion: { },
            onAddRecord: { _ in }
        )
    )
}
#endif
