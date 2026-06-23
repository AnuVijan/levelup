import 'package:flutter/material.dart';
import 'package:levelup/models/task.dart';
class AddTaskScreen extends StatefulWidget {
  final Task? task;
  const AddTaskScreen({super.key, this.task,});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController taskController =TextEditingController();
  final TextEditingController pointsController =
    TextEditingController();
  String selectedCategory = "Learning";
  void initState() {
  super.initState();

  if (widget.task != null) {
    taskController.text = widget.task!.title;
    pointsController.text = widget.task!.points.toString();
    selectedCategory = widget.task!.category;
  }
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task',),),
      body: Padding(padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    labelText: "Task Name",
                    border: OutlineInputBorder()
                  ),
                ),

                SizedBox(height: 20,),

             
                  DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Health',
                  child: Text('Health'),
                ),
                DropdownMenuItem(
                  value: 'Learning',
                  child: Text('Learning'),
                ),
                DropdownMenuItem(
                  value: 'Career',
                  child: Text('Career'),
                ),
                DropdownMenuItem(
                  value: 'Discipline',
                  child: Text('Discipline'),
                ),
                DropdownMenuItem(
                  value: 'Mindset',
                  child: Text('Mindset'),
                ),
                DropdownMenuItem(
                  value: 'Social',
                  child: Text('Social'),
                  
                ),
                DropdownMenuItem(
                  value: 'Personal',
                  child: Text('Personal'),),

                  
              ],
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 20),

TextField(
  controller: pointsController,
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    labelText: 'Points',
    border: OutlineInputBorder(),
  ),
),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                   // print("SAVE BUTTON PRESSED");
  Task newTask = Task(
    title: taskController.text,
    category: selectedCategory,
     points: int.parse(pointsController.text),
     completed: false,
  );
  

 Navigator.pop(context, newTask);
},
                 child: Text('Save Task'))
              )   
                
               
  
              ],
            ),
      
      ));
    
  }
}

