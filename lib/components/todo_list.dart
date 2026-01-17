import 'package:flutter/material.dart';

// TODO: Add local storage for the todo list

class Todo {
  String text;
  bool isDone;

  Todo(this.text, this.isDone);
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Todo> _todos = [];
  final TextEditingController _controller = TextEditingController();

  void _addTodo() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _todos.add(Todo(_controller.text.trim(), false));
        _controller.clear();
      });
    }
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  Future<void> _showDeleteDialog(int index) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (result == true) {
      setState(() {
        _todos.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final incompleteTodos = _todos.where((todo) => !todo.isDone).toList();
    final completedTodos = _todos.where((todo) => todo.isDone).toList();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Add a new goal in mind...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _addTodo(),
              ),
            ),
            Container(
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addTodo,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: _todos.isEmpty
              ? const Center(
                  child: Text('No goals yet. Add one above and strive for it!'),
                )
              : Column(
                  children: [
                    if (incompleteTodos.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: incompleteTodos.length,
                          itemBuilder: (context, index) {
                            final todo = incompleteTodos[index];
                            final globalIndex = _todos.indexOf(todo);
                            return Card(
                              child: ListTile(
                                leading: Checkbox(
                                  value: todo.isDone,
                                  onChanged: (value) =>
                                      _toggleTodo(globalIndex),
                                ),
                                title: Text(
                                  todo.text,
                                  style: TextStyle(
                                    decoration: todo.isDone
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: todo.isDone ? Colors.grey : null,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      _showDeleteDialog(globalIndex),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    if (completedTodos.isNotEmpty)
                      ExpansionTile(
                        title: Text('Completed (${completedTodos.length})'),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: completedTodos.length,
                            itemBuilder: (context, index) {
                              final todo = completedTodos[index];
                              final globalIndex = _todos.indexOf(todo);
                              return Card(
                                child: ListTile(
                                  leading: Checkbox(
                                    value: todo.isDone,
                                    onChanged: (value) =>
                                        _toggleTodo(globalIndex),
                                  ),
                                  title: Text(
                                    todo.text,
                                    style: TextStyle(
                                      decoration: todo.isDone
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: todo.isDone ? Colors.grey : null,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () =>
                                        _showDeleteDialog(globalIndex),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}
