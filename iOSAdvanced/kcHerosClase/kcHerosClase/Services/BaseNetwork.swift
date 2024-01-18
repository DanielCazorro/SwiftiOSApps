//
//  BaseNetwork.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import Foundation

// Constantes
let server = "https://dragonball.keepcoding.education"

// Structs de métodos de red

struct HTTPMethods {
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
    
    static let content = "application/json"
}

enum endpoints: String {
    case login = "/api/auth/login"
    case herosList = "api/heros/all"
    case developerList = "api/data/developers"
    case bootcampsList = "/api/data/bootcamps"
}

struct BaseNetwork {
    
    // Monta la request del login
    func getSessionLogin(user: String, password: String) -> URLRequest {
        let urlCad = "\(server)\(endpoints.login.rawValue)"
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        
        var sefCredential = ""
        if let credentials = encodeCredentials {
            sefCredential = "Basic \(credentials)"
        }
        
        // Creamos la request
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        request.addValue(sefCredential, forHTTPHeaderField: "Authorization")
        
        return request
        
    }
    
    // Montamos el request de heroes
    func getSessionHero(filter: String) -> URLRequest {
        let urlCad = "\(server)\(endpoints.login.rawValue)"
        
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        
        // Generamos el JSON y lo metemos en el body de la llamada
        request.httpBody = try? JSONEncoder().encode(HerosFilter(name: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        // Seguridad JWT
        let tokenOptional = loadKC(key: CONST_TOKEN_ID)
        if let tokenJWT = tokenOptional {
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    // Montamos el request de Developers
    func getSessionDevelopers() -> URLRequest {
        let urlCad = "\(server)\(endpoints.developerList.rawValue)"
        
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.get
        
        // Seguridad JWT
        let tokenOptional = loadKC(key: CONST_TOKEN_ID)
        if let tokenJWT = tokenOptional {
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    // Montamos el request de Bootcamps
    func getSessionBootcamps() -> URLRequest {
        let urlCad = "\(server)\(endpoints.bootcampsList.rawValue)"
        
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.get
        
        return request
    }
    
}
