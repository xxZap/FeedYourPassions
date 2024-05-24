//
//  CategoriesListViewModelTests.swift
//  FeedYourPassionsTests
//
//  Created by Alessio Boerio on 20/04/24.
//

import XCTest
import Combine
@testable import FeedYourPassions

final class CategoriesListViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    func test_init_with_emptyCategories() throws {
        let sut = getSUT(categories: [])
        let expectation = XCTestExpectation()

        sut
            .$uiState
            .dropFirst() // because on first iteration is always nil
            .sink { uiState in
                XCTAssertEqual(uiState.categories, [])
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func test_init_with_someCategories() throws {
        let categories: [PassionCategory] = [
            PassionCategory(type: .family),
            PassionCategory(type: .friends)
        ]
        let sut = getSUT(categories: categories)
        let expectation = XCTestExpectation()

        sut
            .$uiState
            .dropFirst() // because on first iteration is always nil
            .sink { uiState in
                XCTAssertEqual(uiState.categories, categories)
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }

    // TODO: missing support to currentValue
//    func test_init_with_someCategories_should_sortTheCategories_by_theirCurrentValue() throws {
//        let categories: [PassionCategory] = [
//            PassionCategory(type: .family),
//            PassionCategory(type: .friends)
//        ]
//        let sut = getSUT(categories: categories)
//
//        let expectedSortedCategories = [categories[1], categories[0]]
//        XCTAssertEqual(sut.uiState.categories, expectedSortedCategories)
//    }

    // TODO: missing support to currentValue
//    func test_currentValue() throws {
//        let categories: [PassionCategory] = [
//            PassionCategory(type: .family)
//        ]
//        let sut = getSUT(categories: categories)
//        XCTAssertEqual(sut.categories[0].currentValue, 20)
//    }

}

extension CategoriesListViewModelTests {
    func getSUT(categories: [PassionCategory]) -> CategoriesListViewModel {
        switch categories.count {
        case 0:
            return CategoriesListViewModel(categoriesController: MockedCategoriesController(.empty))
        default:
            return CategoriesListViewModel(categoriesController: MockedCategoriesController(.valid(categories: categories)))
        }

    }
}
