//
//  DataController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 21/04/24.
//

import Combine

protocol DataController {
    var passionCategories: AnyPublisher<[PassionCategory]?, Never> { get }
}
