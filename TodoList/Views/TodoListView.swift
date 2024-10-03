//
//  TodoListView.swift
//  TodoList
//
//  Created by Ramon Ferreira on 02/10/24.
//

import SwiftUI
import Combine
import SwiftData

struct TodoListView: View {
    @ObservedObject var viewModel: TodoListViewModel
    @State private var newTodoTitle = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.todos) { todo in
                    TodoRowView(todo: todo)
                        .onTapGesture {
                            viewModel.toggleTodoCompletion(todo: todo)
                        }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        viewModel.removeTodo(at: index)
                    }
                }
            }
            
            HStack {
                TextField("New Todo", text: $newTodoTitle)
                Button("Add") {
                    viewModel.addTodo(title: newTodoTitle)
                    newTodoTitle = ""
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchTodos()
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error"),
                  message: Text(error.localizedDescription),
                  dismissButton: .default(Text("OK")))
        }
        .navigationTitle("Todo List")
    }
}
