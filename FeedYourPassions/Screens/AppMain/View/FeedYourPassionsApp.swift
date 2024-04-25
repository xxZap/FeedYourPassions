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
    @State var selectedItem: OPassionCategory?

    init() {
        UINavigationBar.navigationBarColors(background: UIColor(Color.mBackground), titleColor: UIColor(Color.mLightText), tintColor: UIColor(Color.red))
    }

    var body: some Scene {
        WindowGroup {
            GeometryReader { geoProxy in
                NavigationSplitView(
                    columnVisibility: .constant(.doubleColumn),
                    sidebar: {
                        CategoriesListView(viewModel: CategoriesListViewModel(passionsController: Container.shared.passionsController()), selectedItem: $selectedItem)
                    },
                    detail: {
                        if let selectedItem {
                            CategoryDetailView(viewModel: .init(category: selectedItem))
                        } else {
                            emptyView
                        }
                    }
                )
                .navigationSplitViewStyle(.balanced)
                .navigationBarTitleDisplayMode(.inline)
                .tint(Color.mLightText)
                .environment(\.alerterKey, alerter)
                .alert(isPresented: $alerter.isShowingAlert) {
                    alerter.alert ?? Alert(title: Text(""))
                }
            }
        }
    }

    private var emptyView: some View {
        ZStack {
            Color.mBackground
                .ignoresSafeArea()

            Text("Choose one option on the left")
                .font(.subheadline)
                .foregroundStyle(Color.mLightText)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
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
