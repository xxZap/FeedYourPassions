//
//  PassionsViewModelTests.swift
//  FeedYourPassionsTests
//
//  Created by Alessio Boerio on 20/04/24.
//

import XCTest
@testable import FeedYourPassions

final class PassionsViewModelTests: XCTestCase {

    func test_init_with_emptyGroups() throws {
        let sut = getSUT(groups: [])
        XCTAssertEqual(sut.groups, [])
    }

    func test_init_with_someGroups() throws {
        let groups: [PassionGroup] = [
            PassionGroup(
                name: "test",
                passions: [
                    Passion(
                        name: "0",
                        associatedURL: nil,
                        records: (0..<10).map { _ in PassionRecord(date: Date()) }
                    ),
                    Passion(
                        name: "1",
                        associatedURL: nil,
                        records: (0..<7).map { _ in PassionRecord(date: Date()) }
                    )
                ]
            )
        ]
        let sut = getSUT(groups: groups)
        XCTAssertEqual(sut.groups, groups)
    }

    func test_init_with_someGroups_should_sortTheGroups_by_theirCurrentValue() throws {
        let groups: [PassionGroup] = [
            PassionGroup(
                name: "test1",
                passions: [
                    Passion(
                        name: "0",
                        associatedURL: nil,
                        records: (0..<1).map { _ in PassionRecord(date: Date()) }
                    ),
                    Passion(
                        name: "1",
                        associatedURL: nil,
                        records: (0..<1).map { _ in PassionRecord(date: Date()) }
                    )
                ]
            ),
            PassionGroup(
                name: "test2",
                passions: [
                    Passion(
                        name: "0",
                        associatedURL: nil,
                        records: (0..<10).map { _ in PassionRecord(date: Date()) }
                    ),
                    Passion(
                        name: "1",
                        associatedURL: nil,
                        records: (0..<10).map { _ in PassionRecord(date: Date()) }
                    )
                ]
            )
        ]
        let sut = getSUT(groups: groups)

        let expectedSortedGroup = [groups[1], groups[0]]
        XCTAssertEqual(sut.groups, expectedSortedGroup)
    }

    func test_currentValue() throws {
        let groups: [PassionGroup] = [
            PassionGroup(
                name: "test2",
                passions: [
                    Passion(
                        name: "0",
                        associatedURL: nil,
                        records: (0..<10).map { _ in PassionRecord(date: Date()) }
                    ),
                    Passion(
                        name: "1",
                        associatedURL: nil,
                        records: (0..<10).map { _ in PassionRecord(date: Date()) }
                    )
                ]
            )
        ]
        let sut = getSUT(groups: groups)
        XCTAssertEqual(sut.groups[0].currentValue, 20)
    }

}

extension PassionsViewModelTests {
    func getSUT(groups: [PassionGroup]) -> PassionsViewModel {
        PassionsViewModel(groups: groups)
    }
}
