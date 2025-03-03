import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';

abstract interface class TaskRepository {
  Future<void> addTask(Task task);
  Future<List<Task>> getTasks(TaskCategory category);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> syncLocalTasksToRemote();
  Future<void> syncRemoteTasksToLocal();
}
