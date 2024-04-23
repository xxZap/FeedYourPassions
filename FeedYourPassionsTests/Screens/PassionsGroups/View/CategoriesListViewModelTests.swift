//
//  CategoriesListViewModelTests.swift
//  FeedYourPassionsTests
//
//  Created by Alessio Boerio on 20/04/24.
//

import XCTest
@testable import FeedYourPassions

final class CategoriesListViewModelTests: XCTestCase {

    func test_init_with_emptyCategories() throws {
        let sut = getSUT(categories: [])
        XCTAssertEqual(sut.categories, [])
    }

    func test_init_with_someCategories() throws {
        let categories: [OPassionCategory] = [
            OPassionCategory(
                name: "test",
                passions: [
                    OPassion(
                        id: UUID(),
                        name: "0",
                        associatedURL: nil,
                        records: (0..<10).map { _ in OPassionRecord(date: Date()) }
                    ),
                    OPassion(
                        id: UUID(),
                        name: "1",
                        associatedURL: nil,
                        records: (0..<7).map { _ in OPassionRecord(date: Date()) }
                    )
                ]
            )
        ]
        let sut = getSUT(categories: categories)
        XCTAssertEqual(sut.categories, categories)
    }

    func test_init_with_someCategories_should_sortTheCategories_by_theirCurrentValue() throws {
        let categories: [OPassionCategory] = [
            OPassionCategory(
                name: "test1",
                passions: [
                    OPassion(
                        id: UUID(),
                        name: "0",
                        associatedURL: nil,
                        records: (0..<1).map { _ in OPassionRecord(date: Date()) }
                    ),
                    OPassion(
                        id: UUID(),
                        name: "1",
                        associatedURL: nil,
                        records: (0..<1).map { _ in OPassionRecord(date: Date()) }
                    )
                ]
            ),
            OPassionCategory(
                name: "test2",
                passions: [
                    OPassion(
                        id: UUID(),
                        name: "0",
                        associatedURL: nil,
                        records: (0..<10).map { _ in OPassionRecord(date: Date()) }
                    ),
                    OPassion(
                        id: UUID(),
                        name: "1",
                        associatedURL: nil,
                        records: (0..<10).map { _ in OPassionRecord(date: Date()) }
                    )
                ]
            )
        ]
        let sut = getSUT(categories: categories)

        let expectedSortedCategories = [categories[1], categories[0]]
        XCTAssertEqual(sut.categories, expectedSortedCategories)
    }

    func test_currentValue() throws {
        let categories: [OPassionCategory] = [
            OPassionCategory(
                name: "test2",
                passions: [
                    OPassion(
                        id: UUID(),
                        name: "0",
                        associatedURL: nil,
                        records: (0..<10).map { _ in OPassionRecord(date: Date()) }
                    ),
                    OPassion(
                        id: UUID(),
                        name: "1",
                        associatedURL: nil,
                        records: (0..<10).map { _ in OPassionRecord(date: Date()) }
                    )
                ]
            )
        ]
        let sut = getSUT(categories: categories)
        XCTAssertEqual(sut.categories[0].currentValue, 20)
    }

}

extension CategoriesListViewModelTests {
    func getSUT(categories: [OPassionCategory]) -> CategoriesListViewModel {
        CategoriesListViewModel(categories: categories)
    }
}
