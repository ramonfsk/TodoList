//
//  TodoInteractor.swift
//  TodoList
//
//  Created by Ramon Ferreira on 02/10/24.
//

import Foundation
import Combine
import SwiftData

protocol TodoUseCase {
    func fetchTodos() -> AnyPublisher<[Todo], Error>
    func add(title: String) -> AnyPublisher<Void, Error>
    func remove(todo: Todo) -> AnyPublisher<Void, Error>
    func toggleCompletion(todo: Todo) -> AnyPublisher<Void, Error>
}

class TodoInteractor: TodoUseCase {
    private let repository: TodoRepository
    
    init(repository: TodoRepository) {
        self.repository = repository
    }
    
    func fetchTodos() -> AnyPublisher<[Todo], Error> {
        return repository.fetchTodos()
    }
    
    func add(title: String) -> AnyPublisher<Void, Error> {
        if title.isEmpty {
            return Fail(error: TodoError.emptyTitle)
                .eraseToAnyPublisher()
        }
        
        let todo = Todo(title: title)
        return repository.save(todo: todo)
    }
    
    func remove(todo: Todo) -> AnyPublisher<Void, Error> {
        return repository.delete(todo: todo)
    }
    
    func toggleCompletion(todo: Todo) -> AnyPublisher<Void, Error> {
        todo.isCompleted.toggle()
        return repository.update(todo: todo)
    }
}
