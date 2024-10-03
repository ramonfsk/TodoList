//
//  TodoListAppUITests.swift
//  TodoListUITests
//
//  Created by Ramon Ferreira on 02/10/24.
//

import XCTest

final class TodoListAppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAddingTodo() {
        let textField = app.textFields["New Todo"]
        XCTAssertTrue(textField.exists)

        textField.tap()
        textField.typeText("New Todo")

        let addButton = app.buttons["Add"]
        XCTAssertTrue(addButton.exists)

        addButton.tap()

        let todoCell = app.staticTexts["New Todo"]
        XCTAssertTrue(todoCell.exists)
    }

    func testToggleTodoCompletion() {
        let firstTodoCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstTodoCell.exists)

        firstTodoCell.tap()

        let completedTodo = app.staticTexts["New Todo"]
        XCTAssertTrue(completedTodo.exists)
    }
}
