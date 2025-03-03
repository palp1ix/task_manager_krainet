import 'package:flutter/foundation.dart';
import 'package:task_manager_krainet/core/exeptions/exceptions.dart';
import 'package:task_manager_krainet/data/datasources/task_local_data_source.dart';
import 'package:task_manager_krainet/data/datasources/task_remote_data_source.dart';
import 'package:task_manager_krainet/data/models/task_model.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this.taskLocalDataSource, this.taskRemoteDataSource);

  final TaskLocalDataSource taskLocalDataSource;
  final TaskRemoteDataSource taskRemoteDataSource;

  @override
  Future<void> addTask(Task task) async {
    final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        category: task.category,
        date: task.date,
        isCompleted: task.isCompleted);
    if (!kIsWeb) {
      await taskLocalDataSource.saveTask(taskModel);
    }
    try {
      await taskRemoteDataSource.saveTask(taskModel);
    } catch (e) {
      if (kIsWeb) {
        rethrow;
      }
    }
  }

  @override
  Future<List<Task>> getTasks(TaskCategory category) async {
    late List<TaskModel> taskModels;
    if (!kIsWeb) {
      taskModels = await taskLocalDataSource.getTasks(category);
    }
    try {
      taskModels = await taskRemoteDataSource.getTasks(category);
    } catch (e) {
      if (kIsWeb) {
        rethrow;
      }
    }
    return taskModels
        .map((taskModel) => Task(
            id: taskModel.id,
            title: taskModel.title,
            description: taskModel.description,
            category: taskModel.category,
            date: taskModel.date,
            isCompleted: taskModel.isCompleted))
        .toList();
  }

  @override
  Future<void> updateTask(Task task) async {
    final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        category: task.category,
        date: task.date,
        isCompleted: task.isCompleted);
    if (!kIsWeb) {
      await taskLocalDataSource.updateTask(taskModel);
    }
    try {
      await taskRemoteDataSource.updateTask(taskModel);
    } catch (e) {
      if (kIsWeb) {
        rethrow;
      }
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    if (!kIsWeb) {
      await taskLocalDataSource.deleteTask(id);
    }
    try {
      await taskRemoteDataSource.deleteTask(id);
    } catch (e) {
      if (kIsWeb) {
        rethrow;
      }
    }
  }

  @override
  Future<void> syncLocalTasksToRemote() async {
    if (kIsWeb) {
      // No need to sync on web as there's no local storage
      return;
    }

    try {
      // Get all local tasks
      final localTasks = await taskLocalDataSource.getTasks(TaskCategory.all);

      // Upload each local task to remote storage
      for (final task in localTasks) {
        try {
          await taskRemoteDataSource.saveTask(task);
        } catch (e) {
          // Continue syncing other tasks even if one fails
          debugPrint('Failed to sync task ${task.id}: ${e.toString()}');
        }
      }
    } catch (e) {
      throw SyncLocalRemoteException(
          'Failed to sync local tasks to remote: ${e.toString()}');
    }
  }
  
  @override
  Future<void> syncRemoteTasksToLocal() async {
    if (kIsWeb) {
      // No need to sync on web as there's no local storage
      return;
    }

    try {
      // Get all tasks from remote storage
      final remoteTasks = await taskRemoteDataSource.getTasks(TaskCategory.all);

      // Save each remote task to local storage
      for (final task in remoteTasks) {
        try {
          // First try to update in case the task already exists locally
          await taskLocalDataSource.updateTask(task);
        } catch (e) {
          try {
            // If update fails, try saving as a new task
            await taskLocalDataSource.saveTask(task);
          } catch (e) {
            // Continue syncing other tasks even if one fails
            debugPrint('Failed to sync remote task ${task.id} to local: ${e.toString()}');
          }
        }
      }
    } catch (e) {
      throw SyncLocalRemoteException(
          'Failed to sync remote tasks to local: ${e.toString()}');
    }
  }
}
