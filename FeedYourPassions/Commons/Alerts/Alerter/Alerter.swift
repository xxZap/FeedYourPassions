//
//  Alerter.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 25/04/24.
//

import SwiftUI

class Alerter: ObservableObject {
    @Published var isShowingAlert = false
    @Published var alert: AppAlert? {
        didSet { isShowingAlert = alert != nil }
    }
}

struct AlerterKey: EnvironmentKey {
    static let defaultValue = Alerter()
}

extension EnvironmentValues {
    var alerterKey: Alerter {
        get { self[AlerterKey.self] }
        set { self[AlerterKey.self] = newValue }
    }
}

extension View {
    func registerAlerter(_ alerter: Alerter) -> some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .alert(
                    isPresented: Binding(
                        get: { alerter.isShowingAlert },
                        set: { if !$0 { alerter.alert = nil } }
                    ),
                    appAlert: alerter.alert
                )

            self
        }
        .environment(\.alerterKey, alerter)
    }
}
