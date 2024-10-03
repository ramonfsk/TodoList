//
//  TodoDataRepository.swift
//  TodoList
//
//  Created by Ramon Ferreira on 02/10/24.
//

import Foundation
import Combine
import SwiftData

class TodoDataRepository: TodoRepository {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func save(todo: Todo) -> AnyPublisher<Void, Error> {
        return Future { promise in
            self.context.insert(todo)
            do {
                try self.context.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func delete(todo: Todo) -> AnyPublisher<Void, Error> {
        return Future { promise in
            self.context.delete(todo)
            do {
                try self.context.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchTodos() -> AnyPublisher<[Todo], Error> {
        return Future { promise in
            let request = FetchDescriptor<Todo>(sortBy: [SortDescriptor(\.title)])
            do {
                let todos = try self.context.fetch(request)
                promise(.success(todos))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func update(todo: Todo) -> AnyPublisher<Void, Error> {
        return Future { promise in
            do {
                try self.context.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
