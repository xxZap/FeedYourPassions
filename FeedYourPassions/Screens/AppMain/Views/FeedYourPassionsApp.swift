//
//  FeedYourPassionsApp.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Meteor
import SwiftUI
import Factory
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct FeedYourPassionsApp: App {

    @StateObject var alerter: Alerter = Alerter()
    @StateObject var viewModel = AppRootViewModel()
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
            Group {
                switch viewModel.uiState.user {
                case .success:
                    CategoriesListScreen(viewModel: .init())
                case .loading:
//                    LoadingScreen()
                    emptyView
                case .none, .failure:
                    AuthenticationScreen(viewModel: .init())
                }
            }
            .animation(.smooth, value: viewModel.uiState)
            .onAppear {
                viewModel.restoreSession()
            }
            .onOpenURL { url in
                GIDSignIn.sharedInstance.handle(url)
            }
            .registerAlerter(alerter)
        }
    }

    private var emptyView: some View {
        VStack {
            Spacer()
            MSpinner(size: .large, color: .accent)
            Text("Logging in...")
                .font(.footnote)
                .foregroundStyle(Color.mLightText)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.mBackground)
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
