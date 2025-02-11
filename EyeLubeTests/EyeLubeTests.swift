//
//  EyeLubeTests.swift
//  EyeLubeTests
//
//  Created by oxremy on 2/10/25.
//

import XCTest
@testable import EyeLube

class EyeLubeTests: XCTestCase {
    func testFadeToggle() {
        let fader = ScreenFader()
        let initialOpacity = fader.isFaded
        
        fader.toggleFade()
        XCTAssertNotEqual(fader.isFaded, initialOpacity)
        
        let expectation = XCTestExpectation(description: "Fade animation completes")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
