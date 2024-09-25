//
//  MockUserService.swift
//  GitHubUsersMFTests
//
//  Created by Shashi Nishantha on 9/23/24.
//

import Foundation
@testable import GitHub_Users


class MockUserService{
    
    init(){
        // initiali
    }
    
    func loadUserList() -> [UserList]? {
        if let url = Bundle.main.url(forResource: "gitHubUsers", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([UserList].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func loadUserJson() -> User? {
        if let url = Bundle.main.url(forResource: "gitHubUser", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(User.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func loadRepoJson() -> [Repo]? {
        if let url = Bundle.main.url(forResource: "gitHubUserRepo", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Repo].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
}
