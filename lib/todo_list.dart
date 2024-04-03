import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todo_demo/todo.dart';
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  void loadTodos() async {
    todos.clear();
    final response = await http
        .get(Uri.parse('https://nest-todo.demo.codingshadows.com/todo'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      for (final item in data) {
        todos.add(Todo(
          id: item['id'],
          title: item['title'],
          description: item['description'],
          done: item['done'],
        ));
      }
      setState(() {});
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to load todos'),
          action: SnackBarAction(
            label: 'Retry',
            onPressed: loadTodos,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
                trailing: Checkbox(
                  value: todo.done,
                  onChanged: (value) {
                    setState(() {
                      todo.done = value!;
                    });
                  },
                ),
              );
            },
          );
  }
}
