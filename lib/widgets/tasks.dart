import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoet_flutter/models/task_data.dart';



class TaskTitle extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function(bool?) checkboxCallback;

  TaskTitle({required this.isChecked, required this.taskTitle, required this.checkboxCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taskTitle,style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null)),
      trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
          onChanged:(newValue){
            checkboxCallback(newValue);
          },
      ),
    );
  }
}
class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context,taskData,child){
        return ListView.builder(itemBuilder: (context,index) {
          final task= taskData.tasks[index];
          return TaskTitle(
              isChecked:task.isDone ,
              taskTitle: task.name,
              checkboxCallback: (checkBoxState){
                  taskData.updateTask(task);
              }
          );
        },itemCount: taskData.taskCount);
      },
    );
  }
}
