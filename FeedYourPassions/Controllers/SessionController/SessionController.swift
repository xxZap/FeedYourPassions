//
//  SessionController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 17/05/24.
//

import Combine
import FirebaseAuth

protocol SessionController {
    var loggedUser: AnyPublisher<AsyncResource<User>?, Never> { get }
    var currentUser: User? { get }

    func restoreSession()
    func logout()

    // Google
    func loginWithGoogle()
}
