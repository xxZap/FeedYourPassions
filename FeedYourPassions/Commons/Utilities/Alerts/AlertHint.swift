//
//  AlertHint.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/05/24.
//

import SwiftUI

extension AppAlert {
    enum Definition {
        private static let titlePrefix = "🔎 "

        static func PassionName(onDismiss: @escaping (() -> Void)) -> AppAlert {
            AppAlert(
                title: titlePrefix + "Passion name",
                message: "The name of the passion that you'll see inside its category",
                alertButtons: [
                    .init("Ok", role: .default, action: onDismiss)
                ]
            )
        }

        static func AssociatedURL(onDismiss: @escaping (() -> Void)) -> AppAlert {
            AppAlert(
                title: titlePrefix + "Associated URL",
                message: """
                If a passion has an associated URL, you'll be able to launch it with a dedicated button:
                - if the associated URL can open the related App, it will do it.
                - otherwise it will open Safari as well.
                """,
                alertButtons: [
                    .init("Ok", role: .default, action: onDismiss)
                ]
            )
        }

        static func AssociatedApp(onDismiss: @escaping (() -> Void)) -> AppAlert {
            AppAlert(
                title: titlePrefix + "Associated App",
                message: """
                Similar to "Associated URL", but simpler: you can connect a passion to one of our supported applications. If you have that application installed on your device, you can open it through Grouap.
                """,
                alertButtons: [
                    .init("Ok", role: .default, action: onDismiss)
                ]
            )
        }
    }
}
