import 'package:flutter/cupertino.dart';
import 'dart:collection';

import 'package:todoet_flutter/models/task.dart';



class TaskData extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(name: 'Buy milk',),
    Task(name: 'Buy eggs',),
    Task(name: 'Buy bread',),
  ];
  //只读
  UnmodifiableListView<Task> get tasks{
    return UnmodifiableListView(_tasks);
  }
  void addTask(String newTaskTitle){
    final task=Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }
  void updateTask(Task task){
    task.toggleDone();
    notifyListeners();
  }
  int get taskCount{
    return _tasks.length;
  }
}