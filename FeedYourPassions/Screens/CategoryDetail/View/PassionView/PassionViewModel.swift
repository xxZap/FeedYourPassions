//
//  PassionViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 27/04/24.
//

import SwiftUI
import Combine

class PassionViewModel: ObservableObject {

    struct AlertContainer: Equatable {
        static func == (lhs: PassionViewModel.AlertContainer, rhs: PassionViewModel.AlertContainer) -> Bool {
            lhs.id == rhs.id
        }

        let id = UUID()
        let alert: Alert
    }

    var passion: Passion
    var associatedURL: URL? { if let string = passion.associatedURL { URL(string: string) } else { nil } }
    @Published var alertContainer: AlertContainer?

//    private var onNewRecordAction: ((PassionRecord, PassionID) -> Void)?
//    private let selectedCategoryController: SelectedCategoryController

    init(
        passion: Passion
//        selectedCategoryController: SelectedCategoryController,
//        onNewRecordAction: ((PassionRecord, PassionID) -> Void)?
    ) {
//        self.selectedCategoryController = selectedCategoryController
        self.passion = passion
//        self.onNewRecordAction = onNewRecordAction
    }

//    func addRecord() {
//        let recordDate = Date()
//        alertContainer = AlertContainer(alert: Alert(
//            title: Text("Add a new Record"),
//            message: Text("You are adding a new record for today in the passion \"\(passion.name)\", do you want to proceed?"),
//            primaryButton: .default(Text("Add"), action: { [weak self] in self?.createNewRecord(for: recordDate) }),
//            secondaryButton: .cancel() { [weak self] in self?.alertContainer = nil }
//        ))
//    }

//    private func createNewRecord(for date: Date) {
//        onNewRecordAction?(PassionRecord(date: date), passion.id)
//    }
}
