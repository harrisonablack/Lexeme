//
//  Item.swift
//  Lexeme
//
//  Created by Harrison Black on 22/5/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
