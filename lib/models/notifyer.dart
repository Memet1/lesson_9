import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTasks(String text) {
    _tasks.insert(0, Task(text: text));
    notifyListeners();
  }

  void toggleComplete(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
