//
//  TodoRowView.swift
//  TodoList
//
//  Created by Ramon Ferreira on 02/10/24.
//

import SwiftUI
import SwiftData

struct TodoRowView: View {
    var todo: Todo
    
    var body: some View {
        HStack {
            Text(todo.title)
                .strikethrough(todo.isCompleted, color: .black)
            Spacer()
            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
        }
    }
}
