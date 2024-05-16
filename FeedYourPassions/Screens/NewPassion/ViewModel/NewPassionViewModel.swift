//
//  NewPassionViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import Foundation
import Combine

class NewPassionViewModel: ObservableObject {

    @Published var uiState: NewPassionUIState = NewPassionUIState(title: "", associatedURL: "", category: .init(type: .health, passions: []), canBeSaved: false)

    private var title = CurrentValueSubject<String, Never>("")
    private var associatedURL = CurrentValueSubject<String, Never>("")
    private var uiStatePublisher: AnyPublisher<NewPassionUIState, Never> {
        title
            .combineLatest(associatedURL) { [weak self] title, associatedURL in
                NewPassionUIState(
                    title: title,
                    associatedURL: associatedURL,
                    category: self?.currentCategory ?? .init(type: .family, passions: []),
                    canBeSaved: !title.isEmpty
                )
            }
            .eraseToAnyPublisher()
    }

    private let currentCategory: PassionCategory
    private let dataController: DataController
    private var cancellables = Set<AnyCancellable>()

    init(
        currentCategory: PassionCategory,
        dataController: DataController
    ) {
        self.currentCategory = currentCategory
        self.dataController = dataController
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
            records: []
        )

        dataController.addNewPassion(
            newPassion,
            to: currentCategory
        )
    }
}
