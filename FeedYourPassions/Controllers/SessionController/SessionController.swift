//
//  SessionController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 17/05/24.
//

import Combine
import FirebaseAuth
import FirebaseFirestore

struct UserDetail: Codable {
    let id: String
    let createdAt: Timestamp
    let isAnonymous: Bool
}

protocol SessionController {
    var loggedUser: AnyPublisher<UserDetail?, Never> { get }

    func authenticateAnonymously()
}
