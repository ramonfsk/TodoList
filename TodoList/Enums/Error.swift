//
//  Error.swift
//  TodoList
//
//  Created by Ramon Ferreira on 02/10/24.
//

import Foundation

enum TodoError: Error, Identifiable {
    var id: UUID { UUID() }
    
    case emptyTitle
    case other(Error)

    var localizedDescription: String {
        switch self {
        case .emptyTitle:
            return "The title cannot be empty. Please enter a title for your todo."
        case .other(let error):
            return error.localizedDescription
        }
    }
}
