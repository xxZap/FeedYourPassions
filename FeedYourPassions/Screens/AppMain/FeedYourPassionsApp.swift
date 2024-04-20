//
//  FeedYourPassionsApp.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI

@main
struct FeedYourPassionsApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationSplitView(
                columnVisibility: .constant(.doubleColumn),
                sidebar: {
                    PassionsView(viewModel: PassionsViewModel(groups: mockedGroups))
                },
                detail: {
                    ZStack {
                        FYPColor.background
                            .ignoresSafeArea()

                        Text("Choose one option on the left")
                            .font(.subheadline)
                            .foregroundStyle(FYPColor.lightText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                }
            )
            .navigationSplitViewStyle(.balanced)
        }
    }
}
