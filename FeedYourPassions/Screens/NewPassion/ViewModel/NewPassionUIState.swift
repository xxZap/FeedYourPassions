//
//  NewPassionUIState.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/05/24.
//

import Foundation

struct NewPassionUIState {
    var title: String
    var associatedURL: String?
}

struct NewPassionCalls {
    var onEditTitle: ((String) -> Void)
    var onSave: (() -> Void)
    var onCancel: (() -> Void)
}
