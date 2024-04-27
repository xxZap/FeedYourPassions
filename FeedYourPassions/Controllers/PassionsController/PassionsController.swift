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

    func fetchCategories()

    func setSelectedCategory(_ id: OPassionCategoryID?)
    func addNewPassion(_ passion: OPassion, to categoryID: OPassionCategoryID)
    func addNewRecord(_  record: OPassionRecord, to categoryID: OPassionCategoryID, and passionID: OPassionID)
}
