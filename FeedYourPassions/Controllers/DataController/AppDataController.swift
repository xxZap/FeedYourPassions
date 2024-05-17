//
//  AppDataController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 21/04/24.
//

import Factory
import Combine
import FirebaseAuth
import FirebaseFirestore

struct UserDetail: Codable {
    let id: String
    let createdAt: Timestamp
    let isAnonymous: Bool
}

extension Container {
    var dataController: Factory<DataController> {
        Factory(self) {
            AppDataController()
        }.singleton
    }
}

class AppDataController: DataController {

    private var _user: CurrentValueSubject<User?, Never>

    private var _passionCategories: CurrentValueSubject<[PassionCategory]?, Never>
    var passionCategories: AnyPublisher<[PassionCategory]?, Never> {
        _passionCategories.eraseToAnyPublisher()
    }

    private let db: Firestore
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.db = Firestore.firestore()
        self._user = CurrentValueSubject(nil)
        self._passionCategories = CurrentValueSubject(nil)

        if let user = Auth.auth().currentUser {
            self._user = CurrentValueSubject(user)
        } else {
            Auth.auth().signInAnonymously { [weak self] authResult, error in
                self?._user.send(authResult?.user)
            }
        }

        self._user
            .sink { [weak self] user in
                guard let self = self, let user = user else { return }

                Task { [weak self] in
                    guard let self = self else { return }

                    let userDetail = UserDetail(id: user.uid, createdAt: Timestamp(date: Date()), isAnonymous: true)

                    do {
                        let userRef = self.db.collection("users").document(user.uid)
                        let userDoc = try await userRef.getDocument()
                        if userDoc.exists {
                            print("✅ User \"\(user.uid)\" document already exists")
                            // load data here ...
                        } else {
                            print("❌ User \"\(user.uid)\" document does not exist")
                            print("➡️ Going to create default passion categories structure...")
                            try await createDefaultData(for: userDetail)
                        }
                    } catch {
                        print("❌ User \"\(user.uid)\" document not found")
                        print("➡️ Going to create default passion categories structure...")
                        try await createDefaultData(for: userDetail)
                    }

                    self.attachListener(to: userDetail)
                }
            }
            .store(in: &cancellables)
    }

    func addNewPassion(_ passion: Passion, to category: PassionCategory) {
        guard let user = self._user.value else { return }
        do {
            try db
                .collection("users").document(user.uid)
                .collection("passionCategories").document(category.id ?? "")
                .collection("passions").addDocument(from: passion)

            print("✅ New passion \"\(passion.name)\" added to category \"\(category.name)\" [\(category.id ?? "")]")
        } catch {
            print("❌ Failed to add passion \"\(passion.name)\" to category \"\(category.name)\" [\(category.id ?? "")]: \(error)")
        }
    }
}

extension AppDataController {
    private func createDefaultData(for user: UserDetail) async throws {
        do {
            try db.collection("users").document(user.id).setData(from: user)

            try PassionCategoryType.allCases.forEach { try addPassionCategory($0, to: user) }

            print("✅ Default data successfully created for user \(user.id)")
        } catch {
            print("❌ Failed to create default data for user \(user.id): \(error)")
            do {
                try await db.collection("users").document(user.id).delete()
                print("Successfully delete row data for user \(user.id)")
            } catch {
                print("❌ Failed to delete dirty data for user \(user.id): \(error)")
            }
        }
    }

    private func addPassionCategory(_ type: PassionCategoryType, to user: UserDetail) throws {
        try db
            .collection("users").document(user.id)
            .collection("passionCategories").addDocument(from: PassionCategory(type: type, passions: []))
    }

    private func attachListener(to user: UserDetail) {
        db
            .collection("users").document(user.id)
            .collection("passionCategories")
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("❌ Error getting passionCategories: \(error)")
                    return
                }

                let categories: [PassionCategory] = snapshot?.documents
                    .compactMap{ ($0.documentID, try? $0.data(as: PassionCategory.self)) }
                    .compactMap{ id, category in
                        category?.id = id
                        return category
                    } ?? []

                self?._passionCategories.send(categories)

                print("✅ Got categories: \(categories.map { "\n\t- \($0.name)(\($0.currentValue))" }.joined())")
            }
    }
}

#if DEBUG
class MockedDataController: DataController {
    enum Scenario {
        case none
        case empty
        case valid
    }

    private let _passionCategories: CurrentValueSubject<[PassionCategory]?, Never>
    var passionCategories: AnyPublisher<[PassionCategory]?, Never> { _passionCategories.eraseToAnyPublisher() }

    init(_ scenario: Scenario) {
        switch scenario {
        case .none:
            _passionCategories = CurrentValueSubject(nil)
        case .empty:
            _passionCategories = CurrentValueSubject([])
        case .valid:
            _passionCategories = CurrentValueSubject(mockedCategories)
        }
    }

    func addNewPassion(_ passion: Passion, to category: PassionCategory) {
        
    }
}
#endif
