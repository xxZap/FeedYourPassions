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
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

class RootViewModel: ObservableObject {

    @Published var user: UserDetail? = nil

    private let sessionController: SessionController
    private var cancellables = Set<AnyCancellable>()

    init(sessionController: SessionController) {
        self.sessionController = sessionController

        sessionController.loggedUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)

        sessionController.authenticateAnonymously()
    }
}

@main
struct FeedYourPassionsApp: App {

    @StateObject var viewModel = RootViewModel(sessionController: Container.shared.sessionController())
    @StateObject var alerter: Alerter = Alerter()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

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

                if let user = viewModel.user {
                    CategoriesListScreen(viewModel: .init(categoriesController: Container.shared.categoriesController()))
                } else {
                    MSpinner(size: .large, color: .dark)
                }
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
    ) {
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
