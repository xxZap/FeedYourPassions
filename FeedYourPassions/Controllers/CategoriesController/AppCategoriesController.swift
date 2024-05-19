//
//  AppCategoriesController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 21/04/24.
//

import Factory
import Combine
import FirebaseFirestore

enum DBCollectionKey: String {
    case users
    case passionCategories
    case passions
}

extension Container {
    var categoriesController: Factory<CategoriesController> {
        Factory(self) {
            AppCategoriesController(sessionController: Container.shared.sessionController())
        }.singleton
    }
}

class AppCategoriesController: CategoriesController {

    private var _passionCategories = CurrentValueSubject<[PassionCategory]?, Never>(nil)
    var passionCategories: AnyPublisher<[PassionCategory]?, Never> {
        _passionCategories.eraseToAnyPublisher()
    }

    private var _selectedCategory = CurrentValueSubject<PassionCategory?, Never>(nil)
    var selectedCategory: AnyPublisher<PassionCategory?, Never> {
        _selectedCategory.eraseToAnyPublisher()
    }

    private let db: Firestore
    private let sessionController: SessionController
    private var cancellables = Set<AnyCancellable>()

    init(sessionController: SessionController) {
        self.sessionController = sessionController

        self.db = Firestore.firestore()

        self.sessionController.loggedUser
            .sink { [weak self] user in
                guard let self = self, let user = user else { return }

                Task { [weak self] in
                    guard let self = self else { return }

                    do {
                        let categoriesRef = self.db
                            .collection(DBCollectionKey.users.rawValue).document(user.id)
                            .collection(DBCollectionKey.passionCategories.rawValue)
                        let categoriesDoc = try await categoriesRef.getDocuments()
                        if !categoriesDoc.isEmpty {
                            print("✅ Categories already exist")
                            // load data here ...
                        } else {
                            print("❌ User \"\(user.id)\" has no categories")
                            print("➡️ Going to create default passion categories...")
                            try await createDefaultCategories(for: user)
                        }
                    } catch {
                        print("❌ User \"\(user.id)\"'s categories document not found")
                        print("➡️ Going to create default passion categories...")
                        try await createDefaultCategories(for: user)
                    }

                    self.attachListener(to: user)
                }
            }
            .store(in: &cancellables)
    }

    func selectCategory(_ category: PassionCategory?) {
        _selectedCategory.send(category)
    }
}

extension AppCategoriesController {
    private func createDefaultCategories(for user: UserDetail) async throws {
        do {
            try PassionCategoryType.allCases.forEach { try addPassionCategory($0, to: user) }
            print("✅ Default data successfully created for user \(user.id)")
        } catch {
            print("❌ Failed to create default data for user \(user.id): \(error)")
            do {
                try await db.collection(DBCollectionKey.users.rawValue).document(user.id).delete()
                print("Successfully delete row data for user \(user.id)")
            } catch {
                print("❌ Failed to delete dirty data for user \(user.id): \(error)")
            }
        }
    }

    private func addPassionCategory(_ type: PassionCategoryType, to user: UserDetail) throws {
        try db
            .collection(DBCollectionKey.users.rawValue).document(user.id)
            .collection(DBCollectionKey.passionCategories.rawValue).addDocument(from: PassionCategory(type: type))
    }

    private func attachListener(to user: UserDetail) {
        db
            .collection(DBCollectionKey.users.rawValue).document(user.id)
            .collection(DBCollectionKey.passionCategories.rawValue)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("❌ Error attaching listener to passion categories: \(error)")
                    return
                }

                let categories: [PassionCategory] = snapshot?.documents
                    .compactMap{
                        (
                            $0.documentID,
                            try? $0.data(as: PassionCategory.self)
                        )
                    }
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

    var selectedCategory: AnyPublisher<PassionCategory?, Never> {
        Just(nil).eraseToAnyPublisher()
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

    func selectCategory(_ category: PassionCategory?) {
        
    }
}
#endif
