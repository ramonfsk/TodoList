//
//  TodoRepository.swift
//  TodoList
//
//  Created by Ramon Ferreira on 02/10/24.
//

import Foundation
import Combine
import SwiftData

protocol TodoRepository {
    func save(todo: Todo) -> AnyPublisher<Void, Error>
    func delete(todo: Todo) -> AnyPublisher<Void, Error>
    func fetchTodos() -> AnyPublisher<[Todo], Error>
    func update(todo: Todo) -> AnyPublisher<Void, Error>
}
