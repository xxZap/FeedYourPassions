//
//  AppDataController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 21/04/24.
//

import Factory
import CoreData

extension Container {
    var dataController: Factory<DataController> {
        Factory(self) {
            AppDataController()
        }.singleton
    }
}

class AppDataController: DataController {

    let container: NSPersistentContainer

    init() {
        self.container = NSPersistentContainer(name: "Passions")
        self.container.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to initialize CoreData: \(error)")
            }
        }
    }
}
