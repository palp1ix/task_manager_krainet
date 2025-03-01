import 'package:sqflite/sqflite.dart';
import 'package:task_manager_krainet/core/services/database_service.dart';
import 'package:task_manager_krainet/data/models/task_model.dart';

abstract interface class TaskLocalDataSource {
  Future<void> saveTask(TaskModel task);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  @override
  Future<void> saveTask(TaskModel task) async {
    final db = await DatabaseService.instance.database;

    await db.insert(
      'tasks',
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
