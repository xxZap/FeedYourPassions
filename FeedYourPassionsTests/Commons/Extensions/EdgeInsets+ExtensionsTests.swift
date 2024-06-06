//
//  EdgeInsets+ExtensionsTests.swift
//  FeedYourPassionsTests
//
//  Created by Alessio Boerio on 05/06/24.
//

@testable import Grouap

import XCTest
import SwiftUI

class EdgeInsetsExtensionsTests: XCTestCase {

    func test_zero_init() {
        let sut = EdgeInsets.zero
        XCTAssertEqual(sut, EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
