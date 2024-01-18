//
//  DeveloperModel.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 7/11/23.
//

import Foundation

struct BootCamp: Codable, Identifiable {
    let id, name: String
}

struct DeveloperModel: Codable, Identifiable {
    let apell1, apell2: String
    let id, email: String
    let photo: String
    let name: String
    let bootcamp: BootCamp
    let heros: [Heros]
}
