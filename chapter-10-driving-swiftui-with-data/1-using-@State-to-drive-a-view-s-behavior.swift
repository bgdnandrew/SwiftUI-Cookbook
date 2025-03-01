struct Todo: Identifiable {
    let id = UUID()
    let description: String
    var done: Bool
}

struct ContentView: View {
    @State private var todos = [
        Todo(description: "review the first chapter", done: false),
        Todo(description: "buy wine", done: false),
        Todo(description: "paint kitchen", done: false),
        Todo(description: "cut the grass", done: false),
    ]

    var body: some View {
    # todo is normally a constant, so we can't mutate its value
    # we decorate the original container with '$': $todos
    # we also decorate the internal variable with '$': $todo
    # this way we're actually referencing a todo and operating on a property of the original todo
    # instead of using swift's default behavior (which prioritizes copies)
    # employing this syntax, a todo is now mutable, and a reference to the original array entry; we can safely change its value
        List($todos) { $todo in 
            HStack {
                Text(todo.descritpion)
                    .strikethrough(todo.done)
                Spacer()
                Image(systemName: todo.done ? "checkmark.square" : "square")
             }
             .contentShape(Rectangle()) # the whole row is now hittable/ clickable, not just the text
             .onTapGesture {
                todo.done.toggle()
             }
        }
    }
 } 
