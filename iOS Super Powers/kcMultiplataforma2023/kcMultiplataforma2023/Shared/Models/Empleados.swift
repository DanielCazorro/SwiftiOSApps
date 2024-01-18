//
//  Empleados.swift
//  kcMultiplataforma2023
//
//  Created by Daniel Cazorro Frías on 2/11/23.
//

import Foundation

struct Empleados: Identifiable {
    let id: String
    let nombre: String
    let apell1: String
    let apell2: String?
    let idPhoto: String
    let edad: Int
}

func getTestData() -> [Empleados] {
    return [
    Empleados(id: "10010", nombre: "David", apell1: "Martín", apell2: "Aguirre", idPhoto: "01", edad: 20),
    Empleados(id: "10011", nombre: "Laura", apell1: "Martín", apell2: "Aguirre", idPhoto: "01", edad: 21),
    Empleados(id: "10012", nombre: "Gema", apell1: "Martín", apell2: "Aguirre", idPhoto: "01", edad: 22),
    Empleados(id: "10013", nombre: "Jose", apell1: "Martín", apell2: "Aguirre", idPhoto: "01", edad: 23),
    Empleados(id: "10014", nombre: "Roberto", apell1: "Martín", apell2: "Aguirre", idPhoto: "01", edad: 24),
    Empleados(id: "10015", nombre: "Juan", apell1: "Martín", apell2: "Aguirre", idPhoto: "01", edad: 25),
    Empleados(id: "10016", nombre: "Sara", apell1: "Martín", apell2: "Aguirre", idPhoto: "01", edad: 26),
    Empleados(id: "10017", nombre: "David", apell1: "Martín", apell2: "Aguirre", idPhoto: "01", edad: 27)
    
    ]
}
