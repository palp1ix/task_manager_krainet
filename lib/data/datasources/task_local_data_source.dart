import 'package:sqflite/sqflite.dart';
import 'package:task_manager_krainet/core/exeptions/exceptions.dart';
import 'package:task_manager_krainet/core/services/database_service.dart';
import 'package:task_manager_krainet/data/models/task_model.dart';

abstract interface class TaskLocalDataSource {
  Future<int> saveTask(TaskModel task);
  Future<List<TaskModel>> getTasks(String category);
  Future<int> updateTask(TaskModel task);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  @override
  Future<int> saveTask(TaskModel task) async {
    final db = await DatabaseService.instance.database;

    try {
      final id = await db.insert(
        'tasks',
        task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return id;
    } catch (e) {
      throw LocalDataSourceException(e.toString());
    }
  }

  @override
  Future<List<TaskModel>> getTasks(String category) async {
    final db = await DatabaseService.instance.database;

    try {
      final List<Map<String, dynamic>> maps = await db.query(
        'tasks',
        where: 'category = ?',
        whereArgs: [category],
      );

      return List.generate(maps.length, (i) {
        return TaskModel.fromJson(maps[i]);
      });
    } catch (e) {
      throw LocalDataSourceException(e.toString());
    }
  }

  @override
  Future<int> updateTask(TaskModel task) async {
    final db = await DatabaseService.instance.database;

    try {
      return await db.update(
        'tasks',
        task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id!],
      );
    } catch (e) {
      throw LocalDataSourceException(e.toString());
    }
  }
}
