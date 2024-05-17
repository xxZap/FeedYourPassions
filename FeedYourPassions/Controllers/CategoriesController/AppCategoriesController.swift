//
//  AppCategoriesController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 21/04/24.
//

import Factory
import Combine
import FirebaseAuth
import FirebaseFirestore

extension Container {
    var categoriesController: Factory<CategoriesController> {
        Factory(self) {
            AppCategoriesController(sessionController: Container.shared.sessionController())
        }.singleton
    }
}

class AppCategoriesController: CategoriesController {

    private var _passionCategories: CurrentValueSubject<[PassionCategory]?, Never>
    var passionCategories: AnyPublisher<[PassionCategory]?, Never> {
        _passionCategories.eraseToAnyPublisher()
    }

    private let db: Firestore
    private let sessionController: SessionController
    private var cancellables = Set<AnyCancellable>()

    init(sessionController: SessionController) {
        self.sessionController = sessionController

        self.db = Firestore.firestore()
        self._passionCategories = CurrentValueSubject(nil)

        self.sessionController.loggedUser
            .sink { [weak self] user in
                guard let self = self, let user = user else { return }

                Task { [weak self] in
                    guard let self = self else { return }

                    do {
                        let userRef = self.db.collection("users").document(user.id)
                        let userDoc = try await userRef.getDocument()
                        if userDoc.exists {
                            print("✅ User \"\(user.id)\" document already exists")
                            // load data here ...
                        } else {
                            print("❌ User \"\(user.id)\" document does not exist")
                            print("➡️ Going to create default passion categories structure...")
                            try await createDefaultData(for: user)
                        }
                    } catch {
                        print("❌ User \"\(user.id)\" document not found")
                        print("➡️ Going to create default passion categories structure...")
                        try await createDefaultData(for: user)
                    }

                    self.attachListener(to: user)
                }
            }
            .store(in: &cancellables)
    }

//    func addNewPassion(_ passion: Passion, to category: PassionCategory) {
//        guard let user = self._user.value else { return }
//        do {
//            try db
//                .collection("users").document(user.uid)
//                .collection("passionCategories").document(category.id ?? "")
//                .collection("passions").addDocument(from: passion)
//
//            print("✅ New passion \"\(passion.name)\" added to category \"\(category.name)\" [\(category.id ?? "")]")
//        } catch {
//            print("❌ Failed to add passion \"\(passion.name)\" to category \"\(category.name)\" [\(category.id ?? "")]: \(error)")
//        }
//    }
}

extension AppCategoriesController {
    private func createDefaultData(for user: UserDetail) async throws {
        do {
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
class MockedCategoriesController: CategoriesController {
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
