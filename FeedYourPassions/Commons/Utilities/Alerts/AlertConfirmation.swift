//
//  AlertConfirmation.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/05/24.
//

import SwiftUI

extension AppAlert {

    private static var passionRecordDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter
    }()

    enum Confirmation {
        private static let titlePrefix = "🚦 "

        static func DeletePassion(passionName: String, onAction: @escaping ((Bool) -> Void)) -> AppAlert {
            AppAlert(
                title: titlePrefix + "Warning",
                message: "Are you sure to delete passion \"\(passionName)\"?",
                alertButtons: [
                    .init("Delete", role: .destructive) {
                        onAction(true)
                    },
                    .init("Cancel", role: .cancel) {
                        onAction(false)
                    }
                ]
            )
        }

        static func AddNewRecord(passionName: String, date: Date, onAction: @escaping ((Bool) -> Void)) -> AppAlert {
            AppAlert(
                title: titlePrefix + "Warning",
                message: "Are you sure to add a new record for \(AppAlert.passionRecordDateFormatter.string(from: date)) to passion \"\(passionName)\"?",
                alertButtons: [
                    .init("Confirm", role: .default) {
                        onAction(true)
                    },
                    .init("Cancel", role: .cancel) {
                        onAction(false)
                    }
                ]
            )
        }

        static func logout(onAction: @escaping ((Bool) -> Void)) -> AppAlert {
            AppAlert(
                title: titlePrefix + "Wanna leave?",
                message: "You'll go back to the authentication screen and you'll have to login again.",
                alertButtons: [
                    .init("Logout", role: .destructive) {
                        onAction(true)
                    },
                    .init("Cancel", role: .cancel) {
                        onAction(false)
                    }
                ]
            )
        }
    }
}
