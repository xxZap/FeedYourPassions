//
//  AppSelectedCategoryController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 26/04/24.
//

import Combine
import Factory
import FirebaseFirestore

extension Container {
    var categoryDetailController: Factory<CategoryDetailController> {
        Factory(self) {
            AppCategoryDetailController(
                sessionController: Container.shared.sessionController(),
                categoriesController: Container.shared.categoriesController()
            )
        }.singleton
    }
}

class AppCategoryDetailController: CategoryDetailController {

    private(set) var category: PassionCategory?

    private let _passions = CurrentValueSubject<[Passion]?, Never>(nil)
    var passions: AnyPublisher<[Passion]?, Never> {
        _passions.eraseToAnyPublisher()
    }

    var maxValue: Int {
        // TODO:
        0// _category.value?.maxValue ?? 0
    }

    private let db: Firestore
    private let sessionController: SessionController
    private let categoriesController: CategoriesController
    private var cancellables = Set<AnyCancellable>()

    init(
        sessionController: SessionController,
        categoriesController: CategoriesController
    ) {
        self.db = Firestore.firestore()
        self.sessionController = sessionController
        self.categoriesController = categoriesController

        sessionController.loggedUser
            .combineLatest(categoriesController.selectedCategory) {
                ($0, $1)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] objects in
                let (user, category) = objects
                self?.category = category

                guard
                    let self = self,
                    let user = user,
                    let category = category
                else {
                    return
                }

                self.attachListener(to: user, category: category)
            }
            .store(in: &cancellables)
    }

    func addNewPassion(_ passion: Passion) {
        guard
            let user = self.sessionController.user,
            let category = category
        else {
            return
        }
        // TODO: missing implementation
//        do {
//            try db
//                .collection(DBCollectionKey.users.rawValue).document(user.uid)
//                .collection(DBCollectionKey.passionCategories.rawValue).document(category.id ?? "")
//                .collection(DBCollectionKey.passions.rawValue).addDocument(from: passion)
//
//            print("✅ New passion \"\(passion.name)\" added to category \"\(category.name)\" [\(category.id ?? "")]")
//        } catch {
//            print("❌ Failed to add passion \"\(passion.name)\" to category \"\(category.name)\" [\(category.id ?? "")]: \(error)")
//        }
    }
}

extension AppCategoryDetailController {
    private func attachListener(to user: UserDetail, category: PassionCategory) {
        guard let categoryID = category.id else { return }
        db
            .collection(DBCollectionKey.users.rawValue).document(user.id)
            .collection(DBCollectionKey.passionCategories.rawValue).document(categoryID)
            .collection(DBCollectionKey.passions.rawValue)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let snapshot = snapshot else {
                    print("❌ Error fetching category: \(error!)")
                    return
                }

                if let error = error {
                    print("❌ Error getting category \"\(category.name)\" \(category.id ?? ""): \(error)")
                    return
                }

//                let remoteCategory: PassionCategory? = snapshot.documents
//                    .compactMap{
//                        ($0.documentID, try? $0.data(as: PassionCategory.self))
//                    }
//                    .compactMap{ id, category in
//                        category?.id = id
//                        return category
//                    }.first

                let passions = snapshot.documents.compactMap {
                    try? $0.data(as: Passion.self)
                }

                self?._passions.send(passions)
                print("✅ Got passions from \"\(category.name)\" category: \(passions)")
            }
    }
}

#if DEBUG
class MockedCategoryDetailController: CategoryDetailController {

    enum Scenario {
        case failure
        case empty
        case valid(count: Int)
    }

    private(set) var category: PassionCategory?

    private let _passions: CurrentValueSubject<[Passion]?, Never>
    var passions: AnyPublisher<[Passion]?, Never> {
        _passions.eraseToAnyPublisher()
    }

    var maxValue: Int

    init(_ scenario: Scenario) {
        switch scenario {
        case .failure:
            maxValue = 0
            _passions = CurrentValueSubject(nil)
        case .empty:
            maxValue = 0
            _passions = CurrentValueSubject([])
        case .valid(let count):
            maxValue = 0
            _passions = CurrentValueSubject((0 ..< count).map { Passion(name: "#\($0) Passion", associatedURL: "url", records: [])})
        }
    }

    func addNewPassion(_ passion: Passion) {

    }
}
#endif
