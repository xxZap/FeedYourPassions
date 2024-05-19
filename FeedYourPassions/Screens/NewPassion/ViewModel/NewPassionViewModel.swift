//
//  NewPassionViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import Combine
import Foundation
import FirebaseFirestore

class NewPassionViewModel: ObservableObject {

    @Published var uiState: NewPassionUIState = NewPassionUIState(title: "", associatedURL: "", category: .init(type: .health), canBeSaved: false)

    private var title = CurrentValueSubject<String, Never>("")
    private var associatedURL = CurrentValueSubject<String, Never>("")
    private var uiStatePublisher: AnyPublisher<NewPassionUIState, Never> {
        title
            .combineLatest(associatedURL) { [weak self] title, associatedURL in
                NewPassionUIState(
                    title: title,
                    associatedURL: associatedURL,
                    category: self?.currentCategory ?? .init(type: .family),
                    canBeSaved: !title.isEmpty
                )
            }
            .eraseToAnyPublisher()
    }

    private let currentCategory: PassionCategory
    private let categoryDetailController: CategoryDetailController
    private var cancellables = Set<AnyCancellable>()

    init(
        currentCategory: PassionCategory,
        categoryDetailController: CategoryDetailController
    ) {
        self.currentCategory = currentCategory
        self.categoryDetailController = categoryDetailController
        self.uiStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] uiState in
                self?.uiState = uiState
            }
            .store(in: &cancellables)
    }

    func setTitle(_ newTitle: String) {
        title.send(newTitle)
    }

    func setAssociatedURL(_ url: String) {
        associatedURL.send(url)
    }

    func save() {
        let newPassion = Passion(
            name: uiState.title,
            associatedURL: uiState.associatedURL,
            recordsCount: 0,
            latestUpdate: Timestamp(date: Date())
        )

        categoryDetailController.addNewPassion(newPassion)
    }
}
