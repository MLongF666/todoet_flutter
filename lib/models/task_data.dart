import 'package:flutter/cupertino.dart';
import 'package:todoet_flutter/models/task.dart';
import 'package:todoet_flutter/models/task_dao.dart';

import '../databse/DBUtil.dart';
class TaskData extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(name: 'Buy milk',),
    Task(name: 'Buy eggs',),
    Task(name: 'Buy bread',),
  ];
  //只读
  Future<List<TaskDao>> get tasks async{
    return await DatabaseUtil().getTasks();
  }
  void addTask(String newTaskTitle){
    final task=Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }
  void updateTask(TaskDao task){
    task.toggleDone();
    notifyListeners();
  }
  int get taskCount{
    return _tasks.length;
  }

  void insertTask(String newTaskTitle) async{
    TaskDao task=TaskDao(id: 0, name: newTaskTitle, isDone: 0);
    DatabaseUtil().insertTask(task);
  }
}