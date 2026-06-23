import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'package:levelup/models/task.dart';
import 'package:levelup/services/task_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  final TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final loadedTasks = await taskService.loadTasks();

    setState(() {
      tasks = loadedTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Task> pendingTasks =
        tasks.where((task) => !task.completed).toList();

    List<Task> completedTasks =
        tasks.where((task) => task.completed).toList();

    int growthScore = completedTasks.fold(
      0,
      (sum, task) => sum + task.points,
    );

    int streak = completedTasks.isNotEmpty ? 1 : 0;

    return Scaffold(

      // 🌱 APP BAR
      appBar: AppBar(
        title: const Text("LevelUp"),
        backgroundColor: const Color(0xFF2E7D32),
      ),

      // ☰ DRAWER MENU
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32),
              ),
              child: Text(
                "LevelUp Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.add_task),
              title: const Text("Add Task"),
              onTap: () async {
                Navigator.pop(context);

                final Task? newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTaskScreen(),
                  ),
                );

                if (newTask != null) {
                  setState(() {
                    tasks.add(newTask);
                  });
                  await taskService.saveTasks(tasks);
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.category),
              title: const Text("Categories"),
              onTap: () {},
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Good Morning!!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // 🌟 Growth Score Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Today's Growth Score",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$growthScore',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 Streak Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Current Streak",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "$streak Day${streak == 1 ? '' : 's'}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📌 TASK LIST
            Expanded(
              child: ListView(
                children: [

                  const Text(
                    "Pending Tasks",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  ...pendingTasks.map((task) {
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: task.completed,
                          onChanged: (value) async {
                            setState(() {
                              task.completed = value!;
                            });
                            await taskService.saveTasks(tasks);
                          },
                        ),
                        title: Text(task.title),
                        subtitle: Text(
                          '${task.category} • ${task.points} Points',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                final Task? editedTask =
                                    await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddTaskScreen(task: task),
                                  ),
                                );

                                if (editedTask != null) {
                                  setState(() {
                                    int index =
                                        tasks.indexOf(task);
                                    tasks[index] = editedTask;
                                  });

                                  await taskService.saveTasks(tasks);
                                }
                              },
                            ),

                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                setState(() {
                                  tasks.remove(task);
                                });

                                await taskService.saveTasks(tasks);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  const Text(
                    "Completed Tasks",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  ...completedTasks.map((task) {
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: task.completed,
                          onChanged: (value) async {
                            setState(() {
                              task.completed = value!;
                            });
                            await taskService.saveTasks(tasks);
                          },
                        ),
                        title: Text(task.title),
                        subtitle: Text(
                          '${task.category} • ${task.points} Points',
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),

      // ➕ FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2E7D32),
        onPressed: () async {
          final Task? newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );

          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });

            await taskService.saveTasks(tasks);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}