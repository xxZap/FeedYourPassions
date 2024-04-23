//
//  CategoriesListViewModelTests.swift
//  FeedYourPassionsTests
//
//  Created by Alessio Boerio on 20/04/24.
//

import XCTest
@testable import FeedYourPassions

final class CategoriesListViewModelTests: XCTestCase {

    func test_init_with_emptyGroups() throws {
        let sut = getSUT(groups: [])
        XCTAssertEqual(sut.groups, [])
    }

    func test_init_with_someGroups() throws {
        let groups: [OPassionsGroup] = [
            OPassionsGroup(
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
        let sut = getSUT(groups: groups)
        XCTAssertEqual(sut.groups, groups)
    }

    func test_init_with_someGroups_should_sortTheGroups_by_theirCurrentValue() throws {
        let groups: [OPassionsGroup] = [
            OPassionsGroup(
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
            OPassionsGroup(
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
        let sut = getSUT(groups: groups)

        let expectedSortedGroup = [groups[1], groups[0]]
        XCTAssertEqual(sut.groups, expectedSortedGroup)
    }

    func test_currentValue() throws {
        let groups: [OPassionsGroup] = [
            OPassionsGroup(
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
        let sut = getSUT(groups: groups)
        XCTAssertEqual(sut.groups[0].currentValue, 20)
    }

}

extension CategoriesListViewModelTests {
    func getSUT(groups: [OPassionsGroup]) -> CategoriesListViewModel {
        CategoriesListViewModel(groups: groups)
    }
}
