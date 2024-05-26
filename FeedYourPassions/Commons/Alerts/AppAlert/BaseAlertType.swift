//
//  BaseAlertType.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/05/24.
//

import SwiftUI

protocol AlertType: BaseAlertType & Identifiable & Equatable {}

protocol BaseAlertType {
    var title: String { get }
    var message: String? { get }
    var alertButtons: [AlertButton] { get }
}

struct AlertButton: Identifiable {
    let id = UUID()
    let label: String
    let role: AlertButtonRole
    let action: () -> Void

    init(
        _ label: String,
        role: AlertButtonRole = .default,
        action: @escaping () -> Void = {}
    ) {
        self.label = label
        self.role = role
        self.action = action
    }
}

extension AlertButton {
    var toSystemAlertButton: Alert.Button {
        switch self.role {
        case .`default`:
            return .default(Text(self.label), action: self.action)
        case .cancel:
            return .cancel(Text(self.label), action: self.action)
        case .destructive:
            return .destructive(Text(self.label), action: self.action)
        }
    }

    var toSwiftUIButton: Button<Text> {
        switch self.role {
        case .`default`:
            return Button(action: self.action) {
                Text(self.label)
            }
        case .cancel:
            return Button(role: .cancel, action: self.action) {
                Text(self.label)
            }
        case .destructive:
            return Button(role: .destructive, action: self.action) {
                Text(self.label)
            }
        }
    }
}

enum AlertButtonRole: Equatable {
    case `default`
    case destructive
    case cancel

    var toSystemRole: ButtonRole? {
        switch self {
        case .`default`:
            return .none
        case .cancel:
            return .cancel
        case .destructive:
            return .destructive
        }
    }
}
