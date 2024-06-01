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

    private var _loggedUser = CurrentValueSubject<AsyncResource<User>?, Never>(nil)
    var loggedUser: AnyPublisher<AsyncResource<User>?, Never> { _loggedUser.eraseToAnyPublisher()}

    var currentUser: User? { _loggedUser.value?.successOrNil }

    private let db: Firestore
    private var cancellables = Set<AnyCancellable>()
    private let googleAuthenticator = GoogleAuthenticator()

    init() {
        self.db = Firestore.firestore()
    }

    func restoreSession() {
        _loggedUser.send(.loading)
        if let user = Auth.auth().currentUser {
            print("🟢 Session restored for User \"\(user.uid)\"")
            _loggedUser.send(.success(user))
        } else {
            print("🔴 No active session to restore has been found")
            _loggedUser.send(nil)
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            print("🟢 Logout from Firebase succeeded")
            _loggedUser.send(nil)
        } catch {
            print("🔴 Logout from Firebase failed: \(error)")
        }
    }

    // MARK: - Google

    func loginWithGoogle() {
        googleAuthenticator.authenticate { [weak self] result in
            switch result {
            case .success(let credentials):
                self?.authToFirebase(with: credentials)
            case .failure(let error):
                self?._loggedUser.send(.failure(error))
            }
        }
    }
}

extension AppSessionController {
    private func authToFirebase(with credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { [weak self] result, error in
            if let error {
                print("🔴 Authentication to Firebase failed: \(error)")
                self?._loggedUser.send(.failure(error))
                return
            }

            guard let result = result else {
                print("🔴 Authentication to Firebase failed")
                self?._loggedUser.send(.failure(NSError()))
                return
            }

            let user = result.user
            print("🟢 Authentication to Firebase succeeded for User \"\(user.uid)\"")
            self?._loggedUser.send(.success(user))
//            self?.loadUserDB(user)
        }
    }

//    private func loadUserDB(_ user: User) {
//        Task {
//            do {
//                let userRef = self.db.collection(DBCollectionKey.users.rawValue).document(user.uid)
//                let userDetail = try await userRef.getDocument()
//                print("✅ User \"\(user.uid)\" DB already exists")
//                self._loggedUser.send(.success(user))
//
//            } catch {
//                print("❌ User \"\(user.uid)\" DB not found")
//                print("➡️ Initializing DB...")
//                try await initUserInDB(user)
//            }
//        }
//    }
//
//    private func initUserInDB(_ user: User) async throws {
//        do {
//            try db.collection(DBCollectionKey.users.rawValue).document(user.uid).setData(from: user)
//
//            let usersRef = self.db
//                .collection(DBCollectionKey.users.rawValue).document(user.uid)
//                .collection(DBCollectionKey.passionCategories.rawValue)
//            let categoriesDoc = try await categoriesRef.getDocuments()
//
//            print("✅ User db data succesfully created")
//            self._loggedUser.send(.success(user))
//        } catch {
//            print("❌ Failed to init DB for user \"\(user.uid)\": \(error)")
//            self._loggedUser.send(.failure(error))
//        }
//    }
}
