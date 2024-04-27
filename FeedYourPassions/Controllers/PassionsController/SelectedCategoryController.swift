//
//  SelectedCategoryController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 26/04/24.
//

import Foundation
import Combine

protocol SelectedCategoryController {
    var selectedCategory: AnyPublisher<AsyncResource<OPassionCategory>?, Never> { get }
    var maxValue: Int { get }

    func addNewPassion(_ passion: OPassion)
    func addNewRecord(_ record: OPassionRecord, to passionID: OPassionID)
}
