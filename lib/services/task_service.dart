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
  Future<void> saveStreak(int streak) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('streak', streak);
}

Future<int> loadStreak() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('streak') ?? 0;
}

Future<void> saveLastCompletedDate(String date) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('lastCompletedDate', date);
}

Future<String?> loadLastCompletedDate() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('lastCompletedDate');
}
}