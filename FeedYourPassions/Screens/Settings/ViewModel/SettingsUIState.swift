//
//  SettingsUIState.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 05/06/24.
//

typealias SettingsUIState = AsyncResource<SettingsUIContent>

struct SettingsUIContent {
    var username: String
    var email: String
}

struct SettingsUICalls {
    var onDismissTap: () -> Void
    var onOpenTermsTap: () -> Void
    var onOpenGithubTap: () -> Void
    var onLogoutTap: () -> Void
}
