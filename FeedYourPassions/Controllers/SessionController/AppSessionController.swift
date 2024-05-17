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
    private let _user = CurrentValueSubject<User?, Never>(nil)

    private var _loggedUser = CurrentValueSubject<UserDetail?, Never>(nil)
    var loggedUser: AnyPublisher<UserDetail?, Never> { _loggedUser.eraseToAnyPublisher()}

    private let db: Firestore
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.db = Firestore.firestore()

        self._user
            .sink { [weak self] user in
                guard let self = self, let user = user else { return }

                Task { [weak self] in
                    guard let self = self else { return }

                    do {
                        let userRef = self.db.collection("users").document(user.uid)
                        let userDetail = try await userRef.getDocument(as: UserDetail.self)
                        print("✅ User \"\(user.uid)\" document already exists")
                        self._loggedUser.send(userDetail)

                    } catch {
                        print("❌ User \"\(user.uid)\" document not found")
                        print("➡️ Going to create user object inside the db...")
                        try await initUserInDB(user)
                    }

                }
            }
            .store(in: &cancellables)
    }

    func authenticateAnonymously() {
        if let user = Auth.auth().currentUser {
            self._user.send(user)
        } else {
            Auth.auth().signInAnonymously { [weak self] authResult, error in
                self?._user.send(authResult?.user)
            }
        }
    }
}

extension AppSessionController {
    private func initUserInDB(_ user: User) async throws {
        do {
            let userDetail = UserDetail(id: user.uid, createdAt: Timestamp(date: Date()), isAnonymous: true)
            try db.collection("users").document(user.uid).setData(from: userDetail)
            print("✅ User db data succesfully created")
        } catch {
            print("❌ Failed to init user \(user.uid) to DB: \(error)")
            self._loggedUser.send(nil)
        }
    }
}
