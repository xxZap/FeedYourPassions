//
//  CategoryDetailUIState.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import Foundation

struct CategoryDetailUIState {
    var category: CategoryContainer?
    var passions: [Passion]?
    var title: String { category?.passionCategory.name ?? "?" }
}

struct CategoryDetailUICalls {
    var onCreatePassionTap: (() -> Void)
    var onPassionTap: ((Passion) -> Void)
    var onPassionLaunchTap: ((Passion, URL) -> Void)
    var onPassionAddRecordTap: ((Passion) -> Void)
    var onPassionEditColorTap: ((Passion) -> Void)
    var onPassionRenameTap: ((Passion) -> Void)
    var onPassionEditURLTap: ((Passion) -> Void)
    var onPassionDeleteTap: ((Passion) -> Void)
}
