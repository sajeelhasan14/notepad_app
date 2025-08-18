import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notepad_app/Models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _tasks = List.empty(growable: true);
  List<Todo> get tasks => _tasks;
  String _searchQuery = "";

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<Todo> get searchTasks {
    if (_searchQuery.isEmpty) return _tasks;
    return _tasks
        .where(
          (todo) =>
              todo.task.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  void updateSearchQuery(String input) {
    _searchQuery = input;
    notifyListeners();
  }

  void toggleIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleisDoneValue(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;
    saveTaskSP();
    notifyListeners();
  }

  void addTask(Todo task) {
    _tasks.add(task);
    saveTaskSP();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    saveTaskSP();
    notifyListeners();
  }

  // List<String> todos = ["Buy groceries", "Finish Flutter project", "Call Neha"];
  // prefs.setStringList("todos", todos);
  Future<void> saveTaskSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = _tasks
        .map((task) => jsonEncode(task.toMap()))
        .toList();
    await prefs.setStringList("todos", todoList);
  }

  Future<void> loadTaskSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoList = prefs.getStringList("todos");
    if (todoList != null) {
      _tasks = todoList.map((item) => Todo.fromMap(jsonDecode(item))).toList();
      notifyListeners();
    }
  }
}
