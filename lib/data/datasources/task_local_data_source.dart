import 'package:sqflite/sqflite.dart';
import 'package:task_manager_krainet/core/exeptions/exceptions.dart';
import 'package:task_manager_krainet/core/services/database_service.dart';
import 'package:task_manager_krainet/data/models/task_model.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';

abstract interface class TaskLocalDataSource {
  Future<int> saveTask(TaskModel task);
  Future<List<TaskModel>> getTasks(TaskCategory category);
  Future<int> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
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

  // Add a new method to check if a task with a specific ID exists
  Future<bool> taskExists(String id) async {
    final db = await DatabaseService.instance.database;

    try {
      final result = await db.query(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );

      return result.isNotEmpty;
    } catch (e) {
      throw LocalDataSourceException(e.toString());
    }
  }

  @override
  Future<List<TaskModel>> getTasks(TaskCategory category) async {
    final db = await DatabaseService.instance.database;

    try {
      List<Map<String, dynamic>> maps;

      // For the 'all' category, return all tasks without filtering by category
      if (category == TaskCategory.all) {
        maps = await db.query('tasks');
      }
      // For the 'completed' category, return all tasks that are marked as completed
      else if (category == TaskCategory.completed) {
        maps = await db.query(
          'tasks',
          where: 'isCompleted = ?',
          whereArgs: [1], // In SQLite, true = 1
        );
      }
      // For all other categories, return tasks matching that category
      else {
        maps = await db.query(
          'tasks',
          where: 'category = ?',
          whereArgs: [category.identifier],
        );
      }

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

    if (!await taskExists(task.id)) {
      throw 'Task with this id exist in local storage';
    }

    try {
      return await db.update(
        'tasks',
        task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      throw LocalDataSourceException(e.toString());
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    final db = await DatabaseService.instance.database;

    try {
      await db.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw LocalDataSourceException(e.toString());
    }
  }
}
