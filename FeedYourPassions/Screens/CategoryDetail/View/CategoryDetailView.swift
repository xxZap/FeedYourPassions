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

    var uiState: CategoryDetailUIState
    var calls: CategoryDetailCalls

    var body: some View {
        Group {
            if let category = uiState.category {
                if category.passions.isEmpty {
                    emptyView
                } else {
                    passionsList(category.passions)
                }
            } else {
                loadingView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mBackground)
    }

    private func passionsList(_ passions: [Passion]) -> some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 350))]) {
                    ForEach(Array(passions.enumerated()), id: \.element) { index, passion in
                        PassionView(
                            viewModel: .init(passion: passion),
//                            ) { newRecord, passionID in
//                                calls.onAddRecord((newRecord, passionID))
//                            },
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
                    calls.onCreatePassionTap()
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
        uiState: .init(category: PassionCategory(
            type: .family,
            passions: [Passion(name: "Passion name", records: [])]
        )),
        calls: .init(
            onCreatePassionTap: { }
//            onAddRecord: { _ in }
        )
    )
}
#endif
