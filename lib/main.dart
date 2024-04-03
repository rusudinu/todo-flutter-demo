import 'package:flutter/material.dart';
import 'package:flutter_todo_demo/todo_list.dart';

void main() {
  runApp(const TodoApp());
}

// https://nest-todo.demo.codingshadows.com

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
        ),
        body: const TodoList(),
      ),
    );
  }
}
