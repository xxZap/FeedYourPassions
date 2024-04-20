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
            PassionGroup(name: "test", passions: [Passion(name: "1", currentValue: 1), Passion(name: "2", currentValue: 0)])
        ]
        let sut = getSUT(groups: groups)
        XCTAssertEqual(sut.groups, groups)
    }

    func test_init_with_someGroups_should_sortTheGroups_by_theirCurrentValue() throws {
        let groups: [PassionGroup] = [
            PassionGroup(name: "test1", passions: [Passion(name: "1", currentValue: 1), Passion(name: "2", currentValue: 0)]),
            PassionGroup(name: "test2", passions: [Passion(name: "1", currentValue: 100), Passion(name: "2", currentValue: 100)])
        ]
        let sut = getSUT(groups: groups)

        let expectedSortedGroup = [
            PassionGroup(name: "test2", passions: [Passion(name: "1", currentValue: 100), Passion(name: "2", currentValue: 100)]),
            PassionGroup(name: "test1", passions: [Passion(name: "1", currentValue: 1), Passion(name: "2", currentValue: 0)])
        ]
        XCTAssertEqual(sut.groups, expectedSortedGroup)
    }

    func test_currentValue() throws {
        let groups: [PassionGroup] = [
            PassionGroup(name: "test2", passions: [Passion(name: "1", currentValue: 100), Passion(name: "2", currentValue: 100)])
        ]
        let sut = getSUT(groups: groups)
        XCTAssertEqual(sut.groups[0].currentValue, 200)
    }

}

extension PassionsViewModelTests {
    func getSUT(groups: [PassionGroup]) -> PassionsViewModel {
        PassionsViewModel(groups: groups)
    }
}
