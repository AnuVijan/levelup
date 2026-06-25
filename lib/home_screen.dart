import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'package:levelup/models/task.dart';
import 'package:levelup/services/task_service.dart';
import 'package:levelup/screens/category_screen.dart';
import 'package:levelup/screens/profile_screen.dart';
import 'package:levelup/services/profile_service.dart';
import 'dart:io';
import 'package:levelup/screens/about_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  final TaskService taskService = TaskService();
  final ProfileService profileService =
    ProfileService();
  int currentStreak = 0;
String? lastCompletedDate;
String profileName = "";
String profileEmail = "";
String profileImage = "";

  @override
  void initState() {
    super.initState();
    loadTasks();
    loadStreakData();
    loadProfile();
    
  }
  Future<void> loadProfile() async {
  final profile =
      await profileService.loadProfile();

  setState(() {
    profileName = profile.name;
    profileEmail = profile.email;
     profileImage = profile.imagePath;
  });
}

  Future<void> loadTasks() async {
    final loadedTasks = await taskService.loadTasks();

    setState(() {
      tasks = loadedTasks;
    });
  }
  Future<void> loadStreakData() async {
  currentStreak = await taskService.loadStreak();
  lastCompletedDate =
      await taskService.loadLastCompletedDate();

  setState(() {});
}
Future<void> updateStreak() async {
  DateTime now = DateTime.now();

  String today =
      "${now.year}-${now.month}-${now.day}";

  if (lastCompletedDate == null) {
    currentStreak = 1;
  } else {
    DateTime lastDate =
        DateTime.parse(lastCompletedDate!);

    int difference =
        now.difference(lastDate).inDays;

    if (difference == 1) {
      currentStreak++;
    } else if (difference > 1) {
      currentStreak = 1;
    }
  }

  lastCompletedDate = today;

  await taskService.saveStreak(currentStreak);

  await taskService.saveLastCompletedDate(
    today,
  );

  setState(() {});
}
  @override
  Widget build(BuildContext context) {
   
    List<Task> pendingTasks =
        tasks.where((task) => !task.completed).toList();

    List<Task> completedTasks =
        tasks.where((task) => task.completed).toList();

   int totalPoints = tasks.fold(
  0,
  (sum, task) => sum + task.points,
);

int completedPoints = completedTasks.fold(
  0,
  (sum, task) => sum + task.points,
);

double growthPercentage =
    totalPoints == 0
        ? 0
        : (completedPoints / totalPoints) * 100;

   int completedCount = completedTasks.length;
int totalTaskCount = tasks.length;

    return Scaffold(

      // 🌱 APP BAR
      appBar: AppBar(
        title: const Text("LevelUp"),
        backgroundColor: const Color(0xFF66BB6A),
      ),

      // ☰ DRAWER MENU
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

       DrawerHeader(
  decoration: const BoxDecoration(
    color: Color(0xFF2E7D32),
  ),
  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,
    mainAxisAlignment:
        MainAxisAlignment.center,
    children: [

      CircleAvatar(
  radius: 30,
  backgroundColor: Colors.white,

  backgroundImage:
      profileImage.isNotEmpty
          ? FileImage(File(profileImage))
          : null,

  child: profileImage.isEmpty
      ? const Icon(
          Icons.person,
          size: 35,
          color: Color(0xFF2E7D32),
        )
      : null,
),

      const SizedBox(height: 12),

      Text(
        profileName.isEmpty
            ? "LevelUp User"
            : profileName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 4),

      Text(
        profileEmail.isEmpty
            ? "No Email Added"
            : profileEmail,
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
    ],
  ),
),

            ListTile(
  leading: const Icon(Icons.person),
  title: const Text("Profile"),
  onTap: () async {

    Navigator.pop(context);

  await  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
             ProfileScreen(
                growthScore: growthPercentage.toInt(),
  streak: currentStreak,
 totalTasks: completedTasks.length,
            ),
      ),
    );
     loadProfile(); 
  },
),

            ListTile(
              leading: const Icon(Icons.add_task),
              title: const Text("Add Task"),
              onTap: () async {
                Navigator.pop(context);

                final Task? newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  AddTaskScreen(),
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
              onTap: () {
  Navigator.pop(context);

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
           CategoryScreen(),
    ),

  );
  
},

            ),
         ListTile(
  leading: const Icon(Icons.info),
  title: const Text("About"),
  onTap: () {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const AboutScreen(),
      ),
    );
  },
),
ListTile(
  leading: const Icon(Icons.info),
  title: const Text("Version 1.0"),
  onTap: () {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const AboutScreen(),
      ),
    );
  },
),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          Container(
  width: double.infinity,
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color:  Color(0xFFE8F5E9),
    borderRadius: BorderRadius.circular(12),
  ),
  child: const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Good Morning 👋",
        style: TextStyle(
          
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 5),
      Text(
        "Ready to level up today?",
        style: TextStyle(
          color: Color.fromARGB(255, 13, 13, 13),
        ),
      ),
    ],
  ),
),

            const SizedBox(height: 12),

            // 🌟 Growth Score Card
      Row(
  children: [

    Expanded(
      child: Card(
         color: Colors.green.shade100,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
        child: Padding(
          padding:
              const EdgeInsets.all(12),
          child: Column(
            children: [

              const Text(
                "Growth",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "${growthPercentage.toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: Card(
        elevation: 4,
        color: Colors.green.shade100,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
        child: Padding(
          padding:
              const EdgeInsets.all(12),
          child: Column(
            children: [

              const Text(
                "Done",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                 "$completedCount",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
  child: Card(
    elevation: 4,
    color: Colors.green.shade100,
    shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text("Total", style: TextStyle(
                  fontSize: 10,
                ),),
                const SizedBox(height: 10),
          Text(
            "$totalTaskCount",
            style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
          ),
          
        ],
      ),
    ),
  ),
),
  ],
),
            const SizedBox(height: 12),

            // 🔥 Streak Card
            Card(
              color: Colors.purple.shade50,
              elevation: 4,
              
              
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Current Streak 🔥",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "$currentStreak Day${currentStreak == 1 ? '' : 's'}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

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
                      color: Color(0xFFE8F5E9),
                      child: ListTile(
                        leading: Checkbox(
                          value: task.completed,
                          onChanged: (value) async {
                            setState(() {
                              task.completed = value!;
                            });
                             if (value == true) {
    await updateStreak();
                            await taskService.saveTasks(tasks);
                          }
                    }  ),
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
                      color:  Color(0xFFE8F5E9),
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
        child: const Icon(Icons.add, color: Colors.white,)
        ,
      ),
    );
  }
}