//
//  MockTodoInteractor.swift
//  TodoListTests
//
//  Created by Ramon Ferreira on 02/10/24.
//

import Foundation
import Combine
@testable import TodoList

class MockTodoInteractor: TodoUseCase {
    var todos: [Todo] = []
    var shouldReturnError = false
    
    func fetchTodos() -> AnyPublisher<[Todo], Error> {
        if shouldReturnError {
            return Fail(error: NSError(domain: "", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        return Just(todos)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func add(title: String) -> AnyPublisher<Void, Error> {
        if shouldReturnError {
            return Fail(error: NSError(domain: "", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        let todo = Todo(title: title)
        todos.append(todo)
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func remove(todo: Todo) -> AnyPublisher<Void, Error> {
        if shouldReturnError {
            return Fail(error: NSError(domain: "", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        todos.removeAll { $0.id == todo.id }
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func toggleCompletion(todo: Todo) -> AnyPublisher<Void, Error> {
        if shouldReturnError {
            return Fail(error: NSError(domain: "", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
        }
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
