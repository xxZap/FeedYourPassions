//
//  ExternalLinkProvider.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 05/06/24.
//

import Foundation

enum ExternalLinkProvider {
    case termsAndConditions
    case xxZapGithub

    var urlString: String {
        switch self {
        case .termsAndConditions:
            "https://github.com/xxZap/ios-grouap/blob/main/TERMSANDCONDITIONS.md"
        case .xxZapGithub:
            "https://github.com/xxZap"
        }
    }

    var url: URL? {
        URL(string: self.urlString)
    }
}
