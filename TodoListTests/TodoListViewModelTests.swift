//
//  TodoListViewModelTests.swift
//  TodoListTests
//
//  Created by Ramon Ferreira on 02/10/24.
//

import XCTest
import Combine
@testable import TodoList

final class TodoListViewModelTests: XCTestCase {
    var viewModel: TodoListViewModel!
    var useCase: MockTodoInteractor!
    var cancellables: Set<AnyCancellable>!
    
    let timeout: TimeInterval = 0.1
    
    override func setUp() {
        super.setUp()
        useCase = MockTodoInteractor()
        viewModel = TodoListViewModel(todoUseCase: useCase)
        cancellables = []
    }
    
    override func tearDown() {
        useCase = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchTodos() {
        let expectation = XCTestExpectation(description: "Todos fetched successfully")
        let todo = Todo(title: "Fetch Todo")
        useCase.todos.append(todo)
        
        viewModel.$todos
            .dropFirst()
            .sink { todos in
                XCTAssertEqual(todos.count, 1)
                XCTAssertEqual(todos.first?.title, todo.title)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchTodos()
        
        wait(for: [expectation], timeout: timeout)
    }
    
    func testFetchTodosFailure() {
        let expectation = XCTestExpectation(description: "Handle fetched failure")
        useCase.shouldReturnError = true
        
        let todo = Todo(title: "Fetch Todo")
        useCase.todos.append(todo)
        
        viewModel.$error
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchTodos()
        
        wait(for: [expectation], timeout: timeout)
    }
    
    func testAddTodo() {
        let expectation = XCTestExpectation(description: "Todo added successfully")
        let title = "New Todo"
        
        viewModel.$todos
            .dropFirst()
            .sink { todos in
                XCTAssertEqual(todos.count, 1)
                XCTAssertEqual(todos.first?.title, title)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.addTodo(title: title)
        
        wait(for: [expectation], timeout: timeout)
    }
    
    func testAddTodoFailure() {
        let expectation = XCTestExpectation(description: "Handle add todo failure")
        useCase.shouldReturnError = true
        
        viewModel.$error
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.addTodo(title: "New Todo")
        
        wait(for: [expectation], timeout: timeout)
    }
    
    func testRemoveTodo() {
        let expectation = XCTestExpectation(description: "Todo removed successfully")
        let title = "Todo to Remove"
        
        viewModel.addTodo(title: title)
        
        viewModel.$todos
            .dropFirst()
            .sink { todos in
                XCTAssertEqual(todos.count, 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        guard viewModel.todos.first != nil else {
            XCTFail("Expected todo to remove")
            return
        }
        viewModel.removeTodo(at: 0)
        
        wait(for: [expectation], timeout: timeout)
    }
    
    func testRemoveTodoFailure() {
        let expectation = XCTestExpectation(description: "Handle remove todo failure")
        let title = "Todo to Remove"
        
        viewModel.addTodo(title: title)
        
        useCase.shouldReturnError = true
        
        viewModel.$error
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        guard viewModel.todos.first != nil else {
            XCTFail("Expected todo to remove")
            return
        }
        viewModel.removeTodo(at: 0)
        
        wait(for: [expectation], timeout: timeout)
    }
    
    func testToggleCompletion() {
        let expectation = XCTestExpectation(description: "Todo completion toggled successfully")
        let title = "Todo to Toggle"
        
        viewModel.addTodo(title: title)
        
        viewModel.$todos
            .dropFirst()
            .sink { todos in
                XCTAssertEqual(todos.count, 1)
                XCTAssertTrue(todos.first?.isCompleted ?? false)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        guard let todoToToggle = viewModel.todos.first else {
            XCTFail("Expected todo to toggle")
            return
        }
        viewModel.toggleTodoCompletion(todo: todoToToggle)
        
        wait(for: [expectation], timeout: timeout)
    }
    
    func testToggleCompletionFailure() {
        let expectation = XCTestExpectation(description: "Todo completion toggled failure")
        let title = "Todo to Toggle"
        
        viewModel.addTodo(title: title)
        
        useCase.shouldReturnError = true
        
        viewModel.$error
            .dropFirst()
            .sink { error in
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        guard let todoToToggle = viewModel.todos.first else {
            XCTFail("Expected todo to toggle")
            return
        }
        viewModel.toggleTodoCompletion(todo: todoToToggle)
        
        wait(for: [expectation], timeout: timeout)
    }
}
