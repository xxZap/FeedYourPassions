//
//  CategoryDetailController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 26/04/24.
//

import Foundation
import Combine

protocol CategoryDetailController {
    var category: Category? { get }
    var passions: AnyPublisher<[Passion]?, Never> { get }

    var maxValue: Int { get }

    func addNewPassion(_ passion: Passion)
    func rename(_ passion: Passion, into name: String)
    func setAssociatedURL(_ url: String, to passion: Passion)
    func setColor(_ color: String, to passion: Passion)
    func addRecord(_ record: PassionRecord, to passion: Passion)
    func delete(_ passion: Passion)
}
