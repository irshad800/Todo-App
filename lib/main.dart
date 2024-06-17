import 'package:flutter/material.dart';
import 'package:project_1/screen1.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoHomePage(),
    );
  }
}
