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

    var passion: OPassion
    var maxValue: Int { selectedCategoryController.maxValue }
    @Published var alertContainer: AlertContainer?

    private var onNewRecordAction: ((OPassionRecord, OPassionID) -> Void)?
    private let selectedCategoryController: SelectedCategoryController

    init(
        passion: OPassion,
        selectedCategoryController: SelectedCategoryController,
        onNewRecordAction: ((OPassionRecord, OPassionID) -> Void)?
    ) {
        self.selectedCategoryController = selectedCategoryController
        self.passion = passion
        self.onNewRecordAction = onNewRecordAction
    }

    func addRecord() {
        let recordDate = Date()
        alertContainer = AlertContainer(alert: Alert(
            title: Text("Add a new Record"),
            message: Text("You are adding a new record for today in the passion \"\(passion.name)\", do you want to proceed?"),
            primaryButton: .default(Text("Add"), action: { [weak self] in self?.createNewRecord(for: recordDate) }),
            secondaryButton: .cancel() { [weak self] in self?.alertContainer = nil }
        ))
    }

    private func createNewRecord(for date: Date) {
        onNewRecordAction?(OPassionRecord(date: date), passion.id)
    }
}
