//
//  CategoriesController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 21/04/24.
//

import Combine

protocol CategoriesController {
    var categories: AnyPublisher<AsyncResource<[Category]>?, Never> { get }
    var selectedCategory: AnyPublisher<Category?, Never> { get }

    func fetchCategories()
    func selectCategory(_ category: Category?)
}
