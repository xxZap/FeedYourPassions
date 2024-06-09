//
//  NewPassionViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import Meteor
import Combine
import SwiftUI
import Factory
import FirebaseFirestore

class NewPassionViewModel: ObservableObject {

    @Published var uiState: NewPassionUIState = NewPassionUIState(
        title: "",
        associatedURL: "",
        associatedApp: nil,
        category: .init(type: .health),
        canBeSaved: false,
        supportedApplications: []
    )
    @Published var alert: AppAlert?

    private var title = CurrentValueSubject<String, Never>("")
    private var associatedURL = CurrentValueSubject<String, Never>("")
    private var associatedApp = CurrentValueSubject<SupportedApplication?, Never>(nil)
    private var uiStatePublisher: AnyPublisher<NewPassionUIState, Never> {
        title
            .combineLatest(associatedURL, associatedApp) { [weak self] title, associatedURL, associatedApp in
                NewPassionUIState(
                    title: title,
                    associatedURL: associatedURL,
                    associatedApp: associatedApp,
                    category: self?.currentCategory ?? .init(type: .family),
                    canBeSaved: !title.isEmpty,
                    supportedApplications: self?.supportedApplicationsController.supportedApplications ?? []
                )
            }
            .eraseToAnyPublisher()
    }

    private let currentCategory: PassionCategory
    private var cancellables = Set<AnyCancellable>()

    @Injected(\.categoryDetailController) private var categoryDetailController
    @Injected(\.supportedApplicationsController) private var supportedApplicationsController

    init(currentCategory: PassionCategory) {
        self.currentCategory = currentCategory
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
        associatedApp.send(nil)
    }

    func setAssociatedApp(_ supportedApplication: SupportedApplication?) {
        associatedURL.send("")
        associatedApp.send(supportedApplication)
    }

    func save() -> Bool {
        guard title.value.count > 2 else {
            alert = AppAlert.Error.PassionNameLength(onDismiss: { [weak self] in
                self?.alert = nil
            })
            return false
        }

        var associatedUrl: String = ""
        if !uiState.associatedURL.isEmpty {
            associatedUrl = uiState.associatedURL
        }
        if let app = uiState.associatedApp {
            associatedUrl = app.info.appUrl
        }

        let newPassion = Passion(
            name: uiState.title,
            associatedURL: associatedUrl,
            recordsCount: 0,
            latestUpdate: Timestamp(date: Date()),
            color: ""
        )

        categoryDetailController.addNewPassion(newPassion)
        return true
    }
}
