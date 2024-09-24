//
//  APIClient.swift
//  GitHubUsersMF
//
//  Created by Shashi Nishantha on 9/20/24.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    
    func get(url endpint: String) async throws -> (data: Data?, URLResponse?) {
        guard
            let urlString = endpint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: urlString)
        else { return (nil,nil) }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        return (data, response)
    }
    
    func post(url endpint: String) async throws -> (data: Data?, URLResponse?) {
        guard
            let urlString = endpint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: urlString)
        else { return (nil, nil) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        return (data, response)
    }
}
