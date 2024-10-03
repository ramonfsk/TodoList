//
//  ErrorWrapper.swift
//  TodoList
//
//  Created by Ramon Ferreira on 02/10/24.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID = UUID()
    let message: TodoError
}
