//
//  PassionsController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/04/24.
//

import Foundation
import Combine

protocol PassionsController {
    var groups: AnyPublisher<AsyncResource<[OPassionsGroup]>, Never> { get }

    func fetchGroups()
}
