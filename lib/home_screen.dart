import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'package:levelup/models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
      List<Task> tasks = [];
    
  @override
  Widget build(BuildContext context) {
      List<Task> pendingTasks =
    tasks.where((task) => !task.completed).toList();

List<Task> completedTasks =
    tasks.where((task) => task.completed).toList();
    return Scaffold(

        appBar: AppBar(title: Text("LevelUp"),),

        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text("Good Morning!!", 
                    style: TextStyle(
                        fontSize: 28, 
                        fontWeight: FontWeight.bold
                    ),),

                    SizedBox(height: 20,),

                    Card(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                    child: Column(
                        children: [
                            Text("Today's Growth Score",
                             style: TextStyle(fontSize: 18),),
                            SizedBox(height: 10,),
                            Text('0',
                            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),)
                        ],
                    ),
                        ),
                     ),

                     SizedBox(height: 20),

                     Card(
                        child: Padding(
                            padding: EdgeInsets.all(20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text("Current Streak", style: TextStyle(
                                    fontSize: 18,
                                ),),
                                Text("0 Days", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                ),)
                            ],
                        ),   
                            ),),
                SizedBox(height: 20,),

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
              onChanged: (value) {
                setState(() {
                  task.completed = value!;
                });
              },
            ),
            title: Text(task.title),
            subtitle: Text(
              '${task.category} • ${task.points} Points',
            ),
            trailing: IconButton(
  icon: const Icon(Icons.delete),
  onPressed: () {
    setState(() {
      tasks.remove(task);
    });
  },
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
              onChanged: (value) {
                setState(() {
                  task.completed = value!;
                });
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
)

                ],
            ),
            ),

          
        floatingActionButton: FloatingActionButton(
        onPressed: () async {
  final Task? newTask = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AddTaskScreen(),
    ),
  );

  if (newTask != null) {
    // print("Task received: ${newTask.title}");
    setState(() {
      tasks.add(newTask);
    });
     //print("Total tasks: ${tasks.length}");
  }
},
child: Icon(Icons.add),
        

      ), 
       );
    
  }
}
