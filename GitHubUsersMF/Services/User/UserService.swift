//
//  UserService.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/21/24.
//

import Foundation

class UserService{
    
    private var client:APIClient?
    
    init(apiClient: APIClient = APIClient()){
        client = apiClient
    }
    
    func getUserList(nextCount: Int) async throws -> [UserList]? {
        
        let url = String(format: Endpoints.users.getPath(), nextCount)
        let result = try await client?.get(url: url)
        
        if let data = result?.data {
            let userResponse = try? JSONDecoder().decode([UserList].self, from: data)
            return userResponse
        }
        return nil
    }
    
    
    func getUser(userListObject: UserList) async throws -> User? {
        
        let url = userListObject.url
        let result = try await client?.get(url: url)
        
        if let data = result?.data {
            let userResponse = try? JSONDecoder().decode(User.self, from: data)
            return userResponse
        }
        return nil
    }
    
    func getUserRepoData(userObject: User) async throws -> [Repo]? {
        
        let url = userObject.reposURL
        let result = try await client?.get(url: url)
        
        if let data = result?.data {
            let repoResponse = try? JSONDecoder().decode([Repo].self, from: data)
            return repoResponse
        }
        return nil
    }
}
