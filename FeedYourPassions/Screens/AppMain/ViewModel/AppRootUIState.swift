//
//  AppRootUIState.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 01/06/24.
//

import Foundation
import FirebaseAuth

struct AppRootUIState: Equatable {
    var user: AsyncResource<User>?
}
