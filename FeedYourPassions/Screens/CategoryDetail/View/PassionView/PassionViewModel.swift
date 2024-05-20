//
//  PassionViewModel.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 27/04/24.
//

import SwiftUI
import Combine

private var relativeDateFormatter: RelativeDateTimeFormatter = {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    return formatter
}()

class PassionViewModel: ObservableObject {

    var passion: Passion
    var latestUpdateString: String
    var color: Color?   // TODO: customize color
    var associatedURL: URL? { if let string = passion.associatedURL { URL(string: string) } else { nil } }
    @Published var alert: AppAlert?

//    private var onNewRecordAction: ((PassionRecord, PassionID) -> Void)?
    private let categoryDetailController: CategoryDetailController

    init(
        passion: Passion,
        categoryDetailController: CategoryDetailController
//        onNewRecordAction: ((PassionRecord, PassionID) -> Void)?
    ) {
        self.categoryDetailController = categoryDetailController

        self.passion = passion
        self.latestUpdateString = relativeDateFormatter.localizedString(
            for: passion.latestUpdate.dateValue(),
            relativeTo: Date.now
        )
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

    func rename(into name: String?) {
        guard let name = name, name.count > 2 else {
            alert = AppAlert.Error.PassionNameLength(onDismiss: { [weak self] in
                self?.alert = nil
            })
            return
        }

        categoryDetailController.rename(passion, into: name)
    }
}
