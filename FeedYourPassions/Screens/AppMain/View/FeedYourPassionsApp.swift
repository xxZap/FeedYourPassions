//
//  FeedYourPassionsApp.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI
import Combine
import Factory
import Meteor

@main
struct FeedYourPassionsApp: App {

    @StateObject var alerter: Alerter = Alerter()

    init() {
        UINavigationBar.navigationBarColors(
            background: UIColor(Color.mBackground),
            titleColor: UIColor(Color.mLightText),
            tintColor: UIColor(Color.red)
        )
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                Rectangle()
                    .fill(.clear)
                    .alert(isPresented: $alerter.isShowingAlert) {
                        alerter.alert ?? Alert(title: Text(""))
                    }

                CategoriesListScreen(viewModel: .init(passionsController: Container.shared.passionsController()))
            }
            .environment(\.alerterKey, alerter)
        }
    }
}

extension UINavigationBar {
    static func navigationBarColors(
        background: UIColor?,
        titleColor: UIColor? = nil,
        tintColor: UIColor? = nil
    ){
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear

        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]

        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance

        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}
