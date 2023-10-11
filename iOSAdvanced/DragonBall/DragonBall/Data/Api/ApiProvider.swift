//
//  ApiProvider.swift
//  DragonBall
//
//  Created by Daniel Cazorro Frías on 11/10/23.
//

import Foundation

extension NotificationCenter {
    static let apiLoginNotification = Notification.Name("NOTIFICATION_API_LOGIN")
}

protocol ApiProviderProtocol {
    func login(for user: String, with password: String)
}

class ApiProvider: ApiProviderProtocol {
    
    // MARK: - Constants -
    static private let apiBaseURL = "https://dragonball.keepcoding.education/api"
    
    private enum Endpoint {
        static let login = "/auth/login"
    }
    
    // MARK: - ApiProviderProtocol -
    func login(for user: String, with password:String) {
        guard let url = URL(string: "\(ApiProvider.apiBaseURL)\(Endpoint.login)") else {
            return
        }
        
        guard let loginData = String(format: "%@:%@", user, password).data(using: .utf8)?.base64EncodedString() else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(loginData)",
                            forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            print("Login Response: \(String(describing: response))")
            
        }.resume()
    }
}
