class TaskDao{
  final int id;
  final String name;
  int isDone;

  TaskDao({
    required this.id,
    required this.name,
    this.isDone=0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isDone': isDone,
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name,isDone: $isDone}';
  }

  void toggleDone() {
    if(isDone==0){
      isDone=1;
    }else{
      isDone=0;
    }
  }
}