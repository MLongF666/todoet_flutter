import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task_dao.dart';

class DatabaseUtil{
  late Database _database;
  static const String tableName='tasks';
  void init() async{
    await createDatabase();
  }
  Future<Database> createDatabase() async {
    // 获取数据库路径
    final path = await getDatabasePath('todoet.db');
    // 打开数据库
    final database = openDatabase(
      path,
      version: 1,
      // 当数据库第一次被创建时，执行创建表的操作
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, isDone INTEGER)",
        );
      },
    );
    _database= await database;
    return database;
  }

  Future<String> getDatabasePath(String dbName) async {
    // 获取应用的文档目录
    final directory = await getApplicationDocumentsDirectory();
    // 拼接路径
    final path = join(directory.path, dbName);
    return path;
  }

  Future<void> insertTask(TaskDao task) async{
    await _database.insert(tableName, task.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<TaskDao>> getTasks() async{
    final List<Map<String, dynamic>> maps = await _database.query(tableName);
    return List.generate(maps.length, (i) {
      return TaskDao(
        id: maps[i]['id'],
        name: maps[i]['name'],
        isDone: maps[i]['isDone'],
      );
    });
  }
  Future<void> updateTask(TaskDao task) async{
    await _database.update(tableName, task.toMap(),where: 'id = ?',whereArgs: [task.id]);
  }
  Future<void> deleteTask(TaskDao task) async{
    await _database.delete(tableName,where: 'id = ?',whereArgs: [task.id]);
  }


}