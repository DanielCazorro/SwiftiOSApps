//
//  StatusModel.swift
//  kcHerosClase
//
//  Created by Daniel Cazorro Frías on 6/11/23.
//

import Foundation

enum Status {
    case none, loading, loaded, register, error(error: String)
}
