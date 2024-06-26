//
//  CategoryDetailView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/04/24.
//

import Meteor
import SwiftUI
import Factory
import FirebaseFirestore

struct CategoryDetailView: View {

    var uiState: CategoryDetailUIState
    var uiCalls: CategoryDetailUICalls

    var body: some View {
        Group {
            if let passions = uiState.passions {
                ZStack(alignment: .bottomTrailing) {
                    Group {
                        if passions.isEmpty {
                            emptyView
                        } else {
                            passionsList(passions)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    addNewPassionButton
                }
                .background(Color.mBackground)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                loadingView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mBackground)
        .animation(.smooth, value: uiState.category)
        .animation(.smooth, value: uiState.passions)
    }

    private func passionsList(_ passions: [Passion]) -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 350))]) {
                ForEach(Array(passions.enumerated()), id: \.element) { index, passion in
                    PassionView(
                        viewModel: .init(passion: passion),
                        uiCalls: .init(
                            onTap: {
                                uiCalls.onPassionTap(passion)
                            },
                            onLaunchTap: { url in
                                uiCalls.onPassionLaunchTap(passion, url)
                            },
                            onAddRecordTap: {
                                uiCalls.onPassionAddRecordTap(passion)
                            },
                            onEditColorTap: {
                                uiCalls.onPassionEditColorTap(passion)
                            },
                            onRenameTap: {
                                uiCalls.onPassionRenameTap(passion)
                            },
                            onEditURLTap: {
                                uiCalls.onPassionEditURLTap(passion)
                            },
                            onDeleteTap: {
                                uiCalls.onPassionDeleteTap(passion)
                            }
                        )
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
    }

    private var addNewPassionButton: some View {
        MSideButton(
            image: Image(systemName: "plus"),
            side: .attachedToTheRight
        ) {
            uiCalls.onCreatePassionTap()
        }
        .padding(.bottom, 32)
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
        uiState: .init(
            category: CategoryContainer(passionCategory: PassionCategory(type: .family), maxValue: 0) ,
            passions: [
                Passion(
                    name: "Very long Passion name that can extend on a lot of multiple lines",
                    associatedURL: "some",
                    recordsCount: 222,
                    latestUpdate: Timestamp(date: Date(timeIntervalSince1970: 1716041900)),
                    color: Color.blue.toHex() ?? ""
                ),
                Passion(
                    name: "Passion",
                    associatedURL: nil,
                    recordsCount: 3,
                    latestUpdate: Timestamp(date: Date(timeIntervalSince1970: 1706041900)),
                    color: Color.orange.toHex() ?? ""
                )
            ]
        ),
        uiCalls: .init(
            onCreatePassionTap: { },
            onPassionTap: { _ in },
            onPassionLaunchTap: { _, _ in },
            onPassionAddRecordTap: { _ in },
            onPassionEditColorTap: { _ in },
            onPassionRenameTap: { _ in },
            onPassionEditURLTap: { _ in },
            onPassionDeleteTap: { _ in }
        )
    )
}
#endif
