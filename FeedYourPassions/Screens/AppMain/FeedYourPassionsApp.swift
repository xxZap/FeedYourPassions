//
//  FeedYourPassionsApp.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI
import Combine
import Factory
import Meteor

class RootViewModel {

    @Published var categories: AsyncResource<[OPassionCategory]>

    private var cancellables = Set<AnyCancellable>()

    init() {
        self.categories = .loading

        let passionsController = Container.shared.passionsController()

        passionsController.categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.categories = categories
            }
            .store(in: &cancellables)

        passionsController.fetchGroups()
    }
}

@main
struct FeedYourPassionsApp: App {

    private let viewModel = RootViewModel()

    var body: some Scene {
        WindowGroup {
            GeometryReader { geoProxy in
                NavigationSplitView(
                    columnVisibility: .constant(.doubleColumn),
                    sidebar: {
                        Group {
                            switch viewModel.categories {
                            case .loading:
                                loadingView
                            case .failure(let error):
                                errorView(error)
                            case .success(let categories):
                                CategoriesListView(viewModel: CategoriesListViewModel(categories: categories))
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.mBackground)
                        .toolbar(.hidden, for: .navigationBar)
                    },
                    detail: {
                        ZStack {
                            Color.mBackground
                                .ignoresSafeArea()

                            Text("Choose one option on the left")
                                .font(.subheadline)
                                .foregroundStyle(Color.mLightText)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                    }
                )
                .navigationSplitViewStyle(.balanced)
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

    private func errorView(_ error: Error) -> some View {
        VStack {
            Spacer()
            Text(error.localizedDescription)
            Spacer()
        }
    }
}
