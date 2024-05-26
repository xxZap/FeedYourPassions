//
//  AlertConfirmation.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/05/24.
//

import SwiftUI

extension AppAlert {
    enum Confirmation {
        private static let titlePrefix = "🚦 "

        static func DeletePassion(passionName: String, onAction: @escaping ((Bool) -> Void)) -> AppAlert {
            AppAlert(
                title: titlePrefix + "Warning",
                message: "Are you sure to delete passion \"\(passionName)\"?",
                alertButtons: [
                    .init("Confirm", role: .destructive) {
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
