import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void saveTodo() async {
    final response = await http.post(
      Uri.parse('https://nest-todo.demo.codingshadows.com/todo'),
      body: jsonEncode({
        'id': 1,
        'title': titleController.text,
        'description': descriptionController.text,
        'done': false,
      }),
    );
    if (response.statusCode == 201 && mounted) {
      titleController.clear();
      descriptionController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todo added successfully'),
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add todo'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              saveTodo();
            },
            child: const Text('Add Todo'),
          ),
        ],
      ),
    );
  }
}
