//
//  AppAlert.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/05/24.
//

import SwiftUI

class AppAlert: AlertType {
    var id = UUID()
    var title: String
    var message: String?
    var alertButtons: [AlertButton]
    
    init(title: String, message: String? = nil, alertButtons: [AlertButton]) {
        self.title = title
        self.message = message
        self.alertButtons = alertButtons
    }

    static func == (lhs: AppAlert, rhs: AppAlert) -> Bool {
        lhs.id == rhs.id
    }
}

extension View {
    func alert(isPresented: Binding<Bool>, appAlert: AppAlert?) -> some View {
        let alert = appAlert ?? AppAlert(title: "", alertButtons: [])
        return self.alert(
            alert.title,
            isPresented: isPresented,
            actions: {
                ForEach(alert.alertButtons) { button in
                    button.toSwiftUIButton
                }
            },
            message: {
                if let message = alert.message {
                    Text(message)
                }
            }
        )
    }
}
