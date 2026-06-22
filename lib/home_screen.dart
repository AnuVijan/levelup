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

                     SizedBox(height: 20,),

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
                    child: tasks.isEmpty ? const Card(
                        child: ListTile(
                            leading: Icon(Icons.task_alt),
                            title: Text("No Tasks Yet"),
                            
                        ),
                    )
                    :ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index){
                            return Card(
                                child: ListTile(
                                    leading: Icon(Icons.task_alt),
                                    title: Text(tasks[index].title),
                                    subtitle: Text(tasks[index].category),
                                ),
                            );
                        })
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
     print("Task received: ${newTask.title}");
    setState(() {
      tasks.add(newTask);
    });
     print("Total tasks: ${tasks.length}");
  }
},
child: Icon(Icons.add),
        

      ), 
       );
    
  }
}
