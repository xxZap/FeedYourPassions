//
//  PassionsController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/04/24.
//

import Foundation
import Combine

protocol PassionsController {
    var categories: AnyPublisher<AsyncResource<[OPassionCategory]>, Never> { get }
    var selectedCategoryID: AnyPublisher<AsyncResource<OPassionCategoryID>?, Never> { get }

    func fetchGroups()

    func setSelectedCategory(id: OPassionCategoryID?)
    func addNewPassion(to categoryID: OPassionCategoryID, passion: OPassion)
    func addNewRecord(to passionID: OPassionID, record: OPassionRecord)
}
