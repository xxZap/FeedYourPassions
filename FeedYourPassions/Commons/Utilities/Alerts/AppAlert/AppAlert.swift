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

// ZAPTODO: to move and redefine with AppAlert
extension View {
    func alertWithTextField(
        title: String,
        message: String,
        text: Binding<String?>,
        actionTitle: String,
        actionButtonStyle: UIAlertAction.Style,
        onAction: @escaping (_ fromKeyboard: Bool) -> Void,
        cancelTitle: String,
        cancelButtonStyle: UIAlertAction.Style,
        onCancelAction: @escaping () -> Void
    ) -> some View {
        let isPresented = Binding(
            get: { text.wrappedValue != nil },
            set: { value in
                text.wrappedValue = value ? "" : nil
            }
        )
        return self.alert(
            title,
            isPresented: isPresented,
            actions: {
                TextField(
                    "",
                    text: Binding(
                        get: { text.wrappedValue ?? "" },
                        set: { value in
                            text.wrappedValue = value
                        }
                    )
                )
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .onSubmit {
                    if isPresented.wrappedValue {
                        onAction(true)
                    }
                    isPresented.wrappedValue = false
                }

                if !actionTitle.isEmpty {
                    Button(actionTitle, role: actionButtonStyle.role) {
                        if isPresented.wrappedValue {
                            onAction(false)
                        }
                        isPresented.wrappedValue = false
                    }
                }
                if !cancelTitle.isEmpty {
                    Button(cancelTitle, role: cancelButtonStyle.role) {
                        onCancelAction()
                        isPresented.wrappedValue = false
                    }
                }
            },
            message: {
                if !message.isEmpty {
                    Text(message)
                }
            }
        )
    }
}

extension UIAlertAction.Style {
    var role: ButtonRole? {
        switch self {
        case .cancel:
                .cancel
        case .destructive:
                .destructive
        case .default:
            nil
        @unknown default:
            nil
        }
    }
}
