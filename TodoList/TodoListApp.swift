//
//  TodoListApp.swift
//  TodoList
//
//  Created by Ramon Ferreira on 02/10/24.
//

import SwiftUI
import SwiftData

@main
struct TodoListApp: App {
    private let modelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: Todo.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            let repository = TodoDataRepository(context: modelContainer.mainContext)
            let useCase = TodoInteractor(repository: repository)
            let viewModel = TodoListViewModel(todoUseCase: useCase)
            
            NavigationView {
                TodoListView(viewModel: viewModel)
                    .modelContainer(modelContainer)
            }
        }
    }
}
