//
//  TodoListViewModel.swift
//  TodoList
//
//  Created by Ramon Ferreira on 02/10/24.
//

import Combine
import SwiftUI

final class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var error: TodoError?
    
    private let todoUseCase: TodoUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(todoUseCase: TodoUseCase) {
        self.todoUseCase = todoUseCase
    }
    
    func fetchTodos() {
        todoUseCase.fetchTodos()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.handleWithError(error)
                }
            }, receiveValue: { [weak self] todos in
                self?.todos = todos
            })
            .store(in: &cancellables)
    }
    
    func addTodo(title: String) {
        todoUseCase.add(title: title)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.handleWithError(error)
                }
            }, receiveValue: { [weak self] in
                self?.fetchTodos()
            })
            .store(in: &cancellables)
    }
    
    func toggleTodoCompletion(todo: Todo) {
        todoUseCase.toggleCompletion(todo: todo)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.handleWithError(error)
                }
            }, receiveValue: { [weak self] in
                self?.fetchTodos()
            })
            .store(in: &cancellables)
    }
    
    func removeTodo(at index: Int) {
        let todo = todos[index]
        todoUseCase.remove(todo: todo)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.handleWithError(error)
                }
            }, receiveValue: { [weak self] in
                self?.fetchTodos()
            })
            .store(in: &cancellables)
    }
}

// MARK: - Error Handling
extension TodoListViewModel {
    private func handleWithError(_ error: any Error) {
        if let todoError = error as? TodoError {
            self.error = todoError
        } else {
            self.error = TodoError.other(error)
        }
    }
}
