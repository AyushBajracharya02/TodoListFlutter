import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showform = false;
  final TextEditingController _titleController = TextEditingController();
  String _priority = "";
  final List<Todo> _todoItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do List"),
        centerTitle: true,
      ),
      body: !showform
          ? ListView(
              children: _todoItems
                  .map(
                    (item) => TodoItem(todo: item),
                  )
                  .toList(),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _priority = value!;
                      });
                    },
                    items: ['low', 'medium', 'high']
                        .map((String value) => DropdownMenuItem<String>(
                            value: value, child: Text(value)))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _todoItems.add(Todo(
                            title: _titleController.text, priority: _priority));
                      });
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              showform = !showform;
            });
          },
          child: Icon(
            !showform ? Icons.add : Icons.arrow_back,
            size: 60,
          ),
        ),
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  MaterialColor getColor() {
    return widget.todo.priority == "low"
        ? Colors.green
        : widget.todo.priority == "medium"
            ? Colors.yellow
            : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 50,
        color: getColor(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.todo.title),
              Checkbox(
                value: widget.todo.completed,
                onChanged: (bool? value) {
                  setState(() {
                    widget.todo.completed = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

class Todo {
  Todo({
    required this.title,
    required this.priority,
  });
  final String title;
  final String priority;
  bool completed = false;
}
