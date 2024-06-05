//
//  AppExternalLinkController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 05/06/24.
//

import Factory
import Foundation

extension Container {
    var externalLinkController: Factory<ExternalLinkController> {
        Factory(self) {
            AppExternalLinkController()
        }.singleton
    }
}

class AppExternalLinkController: ExternalLinkController {
    var termsAndConditions: String  = "https://github.com/xxZap/ios-grouap/blob/main/TERMSANDCONDITIONS.md"
    var zapGithubPage: String       = "https://github.com/xxZap"
}
