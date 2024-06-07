//
//  NewPassionUIState.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import Foundation

struct NewPassionUIState {
    var title: String
    var associatedURL: String
    var category: PassionCategory
    var canBeSaved: Bool
}

struct NewPassionUICalls {
    var onEditTitle: ((String) -> Void)
    var onEditAssociatedURL: ((String) -> Void)
    var onSave: (() -> Void)
    var onCancel: (() -> Void)

    var onPassionNameDefinition: (() -> Void)
    var onAssociatedURLDefinition: (() -> Void)
    var onAssociatedAppDefinition: (() -> Void)
}
