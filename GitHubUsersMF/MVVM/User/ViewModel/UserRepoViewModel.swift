//
//  UserRepoViewModel.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/22/24.
//

import Foundation
import Combine

class UserRepoViewModel{
    
    @Published private(set) var userObject: User?
    @Published private(set) var repoObjects: [Repo]?
    @Published private(set) var error: String?
    var selectedUser: UserList?
    private var userFetchTask: Task<Void, Never>? = nil
    private var errorSubject: PassthroughSubject<Error, Never> = .init()
    
    private var service: UserService?
    
    init(userService: UserService = UserService(), user: UserList) {
        service = userService
        selectedUser = user
    }
    
    deinit{
        userFetchTask?.cancel()
    }
    
    @discardableResult
    func fetchUser() -> Task<Void, Never>? {
        userFetchTask?.cancel()
        
        let task = Task{
            do{
                try Task.checkCancellation()
                if let sUser = selectedUser {
                    let user = try await service?.getUser(userListObject: sUser)
                    self.userObject = user
                }
                if let userObj = self.userObject {
                    let repo = try await service?.getUserRepoData(userObject: userObj)
                    self.repoObjects = repo
                }
            }catch{
                self.errorSubject.send(error)
            }
        }
        
        userFetchTask = task
        return task
    }
    
    var user: User? {
        return self.userObject
    }
    
    var repoCount: Int {
        return self.repoObjects?.count ?? 0
    }
    
    func getRepoItem(index: Int) -> Repo? {
        return repoObjects?[index]
    }
}

/// Combine methods
extension UserRepoViewModel{
    
    var userPublisher: AnyPublisher<User, Never> {
        $userObject.compactMap{ $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    var repoPublisher: AnyPublisher<[Repo], Never> {
        $repoObjects.compactMap{ $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<Error, Never>{
        errorSubject.eraseToAnyPublisher()
    }
}
