//
//  UserListViewModelTest.swift
//  GitHubUsersMFTests
//
//  Created by Shashi Nishantha on 9/23/24.
//

import XCTest
@testable import GitHub_Users

final class UserListViewModelTest: XCTestCase {
    
    var service: MockUserService!
    var viewModel: UserListViewModel!
    
    override func setUp() {
        service = MockUserService()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    func testFetchUsers() {
        Task {
            let users = service.loadUserList()
            XCTAssertNotNil(users)
            
            guard let listOfusers = users else { return }
            viewModel = UserListViewModel(users: listOfusers)
            
            XCTAssertNotNil(viewModel.listOfUsers)
            XCTAssertEqual(viewModel.listOfUsers?.count, 30)
            XCTAssertEqual(viewModel.numberOfUsers, 30)
            
            let user = viewModel.getUser(index: 0)
            XCTAssertNotNil(user)
            XCTAssertEqual(user?.login, "bs")
            XCTAssertEqual(user?.type, "User")
            XCTAssertEqual(user?.id, 68)
            
            viewModel = UserListViewModel(users: [])
            XCTAssertEqual(viewModel.listOfUsers, [])
        }
    }
}
