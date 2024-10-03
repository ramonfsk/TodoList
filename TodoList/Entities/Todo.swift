//
//  Todo.swift
//  TodoList
//
//  Created by Ramon Ferreira on 02/10/24.
//

import Foundation
import SwiftData

@Model
class Todo: Identifiable {
    var id: UUID = UUID()
    var title: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
