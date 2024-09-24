//
//  UserListViewModel.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/21/24.
//

import Foundation
import Combine

class UserListViewModel{
    
    @Published private(set) var listOfUsers:[UserList]?
    @Published private(set) var error: String?
    
    private var userFetchTask: Task<Void, Never>? = nil
    private var errorSubject: PassthroughSubject<Error, Never> = .init()
    
    private var service: UserService?
    
    init(userService: UserService = UserService()) {
        service = userService
    }
    
    deinit{
        userFetchTask?.cancel()
    }
    
    var numberOfUsers: Int {
        listOfUsers?.count ?? 0
    }
    
    func getUser(index: Int) -> UserList? {
        return listOfUsers?[index]
    }
    
    @discardableResult
    func fetchUsers(count: Int) -> Task<Void, Never>? {
        userFetchTask?.cancel()
        
        let task = Task{
            do{
                try Task.checkCancellation()
                let users = try await service?.getUserList(nextCount: count)
                //self.listOfUsers = users
                self.listOfUsers = self.loadUserList()
            }catch{
                self.errorSubject.send(error)
            }
        }
        
        userFetchTask = task
        return task
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
}

extension UserListViewModel{
    
    var userListPublisher: AnyPublisher<[UserList], Never> {
        $listOfUsers.compactMap{ $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<Error, Never>{
        errorSubject.eraseToAnyPublisher()
    }
}
