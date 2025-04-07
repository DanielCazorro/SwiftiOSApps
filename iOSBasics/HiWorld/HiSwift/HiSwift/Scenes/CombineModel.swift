//
//  CombineModel.swift
//  HiSwift
//
//  Created by Daniel Cazorro Frías on 31/3/25.
//

import Combine

class CombineModel: ObservableObject {
    @Published var count: Int = 0
    
    func increment() {
        count += 1
    }
}
