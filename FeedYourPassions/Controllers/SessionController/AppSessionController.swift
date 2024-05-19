//
//  AppSessionController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 17/05/24.
//

import Factory
import Combine
import FirebaseAuth
import FirebaseFirestore

extension Container {
    var sessionController: Factory<SessionController> {
        Factory(self) {
            AppSessionController()
        }.singleton
    }
}

class AppSessionController: SessionController {
    private let _firebaseSessionUser = CurrentValueSubject<User?, Never>(nil)

    private var _loggedUser = CurrentValueSubject<UserDetail?, Never>(nil)
    var loggedUser: AnyPublisher<UserDetail?, Never> { _loggedUser.eraseToAnyPublisher()}

    var user: UserDetail?

    private let db: Firestore
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.db = Firestore.firestore()

        self._firebaseSessionUser
            .sink { [weak self] sessionUser in
                guard let sessionUser = sessionUser else {
                    self?.logout()
                    return
                }

                Task { [weak self] in
                    guard let self = self else { return }

                    do {
                        let userRef = self.db.collection(DBCollectionKey.users.rawValue).document(sessionUser.uid)
                        let userDetail = try await userRef.getDocument(as: UserDetail.self)
                        print("✅ User \"\(sessionUser.uid)\" document already exists")
                        self._loggedUser.send(userDetail)
                        self.user = userDetail

                    } catch {
                        print("❌ User \"\(sessionUser.uid)\" document not found")
                        print("➡️ Going to create user object inside the db...")
                        try await initUserInDB(sessionUser)
                    }

                }
            }
            .store(in: &cancellables)
    }

    func authenticateAnonymously() {
        if let user = Auth.auth().currentUser {
            self._firebaseSessionUser.send(user)
        } else {
            Auth.auth().signInAnonymously { [weak self] authResult, error in
                self?._firebaseSessionUser.send(authResult?.user)
            }
        }
    }
}

extension AppSessionController {
    private func initUserInDB(_ sessionUser: User) async throws {
        do {
            let user = UserDetail(id: sessionUser.uid, createdAt: Timestamp(date: Date()), isAnonymous: true)
            try db.collection(DBCollectionKey.users.rawValue).document(sessionUser.uid).setData(from: user)
            print("✅ User db data succesfully created")
            self._loggedUser.send(user)
            self.user = user
        } catch {
            print("❌ Failed to init user \(sessionUser.uid) to DB: \(error)")
            self._loggedUser.send(nil)
            self.user = nil
        }
    }

    private func logout() {
        _loggedUser.send(nil)
        user = nil
    }
}
