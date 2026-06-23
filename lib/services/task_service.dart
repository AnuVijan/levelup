import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:levelup/models/task.dart';

class TaskService {
  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> taskList =
        tasks.map((task) => jsonEncode(task.toMap())).toList();

    await prefs.setStringList('tasks', taskList);
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? taskList = prefs.getStringList('tasks');

    if (taskList == null) {
      return [];
    }

    return taskList.map((taskString) {
      return Task.fromMap(
        jsonDecode(taskString),
      );
    }).toList();
  }
}