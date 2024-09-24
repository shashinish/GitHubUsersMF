//
//  Constants.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/19/24.
//

import Foundation

enum Constants {
    static var baseUrl = "https://api.github.com/"
    
}

enum Endpoints: String {
    case users = "users?since=%d"
    
    func getPath() -> String{
        switch self {
        case .users:
            return "\(Constants.baseUrl)\(self.rawValue)"
        }
    }
}
