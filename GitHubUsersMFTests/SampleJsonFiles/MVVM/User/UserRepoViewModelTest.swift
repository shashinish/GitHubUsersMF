//
//  UserRepoViewModelTest.swift
//  GitHubUsersMFTests
//
//  Created by Shashi Nishantha on 9/23/24.
//

import XCTest
@testable import GitHub_Users

final class UserRepoViewModelTest: XCTestCase {
    
    var service: UserService!
    var mockService: MockUserService!
    var viewModel: UserRepoViewModel!

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }
    
    override func setUp() {
        service = UserService()
        mockService = MockUserService()
    }
    
    func testGetUser() async throws {
        let userListObjects = mockService.loadUserList()
        XCTAssertNotNil(userListObjects)
        guard let userListUser = userListObjects?[0] else {return}
        Task{
            viewModel = UserRepoViewModel(userService: service, user: userListUser)
            viewModel.fetchUser()
            
            XCTAssertNil(viewModel.user)
            XCTAssertEqual(viewModel.repoCount, 0)
            XCTAssertNil(viewModel.getRepoItem(index: 0))
        }
    }
}
