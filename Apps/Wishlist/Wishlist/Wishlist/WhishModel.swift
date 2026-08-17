//
//  WishModel.swift
//  Wishlist
//
//  Created by Daniel Cazorro on 15/08/2026.
//

import Foundation
import SwiftData

@Model
final class Wish {
    var title: String
    var createdAt: Date
    var isCompleted: Bool
    
    init(title: String, createdAt: Date = .now, isCompleted: Bool = false) {
        self.title = title
        self.createdAt = createdAt
        self.isCompleted = isCompleted
    }
}
