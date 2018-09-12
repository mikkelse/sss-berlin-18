import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    // Basic "Hello, world!" example
    router.get("hello", String.parameter) { req -> String in
        let name = try req.parameters.next() as String
        return "Hello, \(name)"
    }

    struct JSONExample: Content {
        let name: String
        let age: Int
        let birthday: Date
    }

    router.get("json") { request -> JSONExample in
        return JSONExample(
            name: "Dude",
            age: 42,
            birthday: Date()
        )
    }

    // Example of configuring a controller
    let todoController = TodoController()
    let todos = router.grouped("todos")
    let todo = todos.grouped(Todo.parameter)
    todos.get(use: todoController.index)
    todo.get(use: todoController.view)
    todos.post(use: todoController.create)
    todo.patch(use: todoController.update)
    todo.delete(use: todoController.delete)
    todos.delete(use: todoController.clear)
}
