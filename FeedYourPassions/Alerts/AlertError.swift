//
//  AlertError.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/05/24.
//

import SwiftUI

extension AppAlert {
    enum Error {
        private static let titlePrefix = "❌ "

        static func PassionNameLength(onDismiss: @escaping (() -> Void)) -> AppAlert {
            AppAlert(
                title: titlePrefix + "Error",
                message: "You've to set a minimum of 2 characters",
                alertButtons: [
                    .init("ok", role: .default, action: onDismiss)
                ]
            )
        }
    }
}
