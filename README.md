# Todo List App

A simple and elegant Todo List application built with **SwiftUI**, **SwiftData**, **Combine**, and **Clean Architecture**. This project serves as a practical example for students looking to learn about modern iOS development practices.

## Table of Contents

- [Todo List App](#todo-list-app)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Technologies Used](#technologies-used)
  - [Getting Started](#getting-started)
  - [Usage](#usage)
  - [Testing](#testing)
  - [Contributing](#contributing)
  - [License](#license)

## Features

- Create, read, update, and delete todo items.
- Input validation to prevent empty todos.
- Persistent storage using SwiftData.
- Error handling with user-friendly alerts.
- Built with Combine for reactive programming.
- Organized using Clean Architecture principles.

## Technologies Used

- **SwiftUI**: For building the user interface.
- **SwiftData**: For data persistence.
- **Combine**: For handling asynchronous events.
- **Clean Architecture**: To organize the codebase effectively.

## Getting Started

To run this project locally, follow these steps:

1. **Clone the repository**:
  ```bash
  git clone https://github.com/ramonfsk/TodoList.git
  cd todo-list-app
  ```
2. **Open the project in Xcode**:
  ```bash
  open TodoList.xcodeproj
  ```

3. **Run the app**:
   - Select a simulator or a connected device.
   - Press ```Cmd + R``` to build and run the app.

## Usage

1. Adding a Todo:
   - Tap on the text field at the top to enter a todo title.
   - Press the "Add" button to save it.
2. Marking as Complete:
   - Tap on a todo item to toggle its completion status.
3. Deleting a Todo:
   - Swipe left on a todo item to reveal the delete option.
4. Handling Errors:
   - If you try to add an empty todo, an alert will notify you.

## Testing

To run tests for the ViewModel, use the following steps:

1. Open the test target in Xcode.
2. Run all tests by selecting ```Product > Test``` or pressing ```Cmd + U```.

The tests are structured to validate the functionality of adding, removing, and fetching todos using a mock repository.

## Contributing

Contributions are welcome! If you have suggestions for improvements or find bugs, please open an issue or submit a pull request.

1. Fork the repository.
2. Create a new branch (git checkout -b feature/YourFeature).
3. Make your changes and commit them (git commit -m 'Add some feature').
4. Push to the branch (git push origin feature/YourFeature).
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.