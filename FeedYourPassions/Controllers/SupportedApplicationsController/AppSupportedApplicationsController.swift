//
//  AppSupportedApplicationsController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 07/06/24.
//

import SwiftUI
import Factory

extension Container {
    var supportedApplicationsController: Factory<SupportedApplicationsController> {
        Factory(self) {
            AppSupportedApplicationsController()
        }.singleton
    }
}

class AppSupportedApplicationsController: SupportedApplicationsController {
    var supportedApplications: [SupportedApplication?]

    init() {
        var applications: [SupportedApplication?] = SupportedApplication.allCases
        applications.append(nil)
        applications.sort(by: { first, second in
            if let first, let second {
                return first.info.displayName < second.info.displayName
            } else {
                return true
            }
        })
        self.supportedApplications = applications
    }
}
