//
//  UserListViewModelTest.swift
//  GitHubUsersMFTests
//
//  Created by Shashi Nishantha on 9/23/24.
//

import XCTest
import GitHubUsersMF

final class UserListViewModelTest: XCTestCase {
    
    let service: MockUserService!
    
    override func setUp() {
        service = MockUserService()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchUserList(){
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
