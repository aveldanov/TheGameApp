//
//  TheGameAppUITests.swift
//  TheGameAppUITests
//
//  Created by Anton Veldanov on 11/30/21.
//

import XCTest

class TheGameAppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testLandingPage_WhenPlayButtonClicked_MainScreenOpens() {
        app.buttons.element.firstMatch.tap()
        XCTAssertTrue(app.buttons["reset"].exists)
    }
}
