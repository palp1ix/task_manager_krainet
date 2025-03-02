import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';

abstract interface class TaskRepository {
  Future<int> addTask(Task task);
  Future<List<Task>> getTasks(TaskCategory category);
  Future<int> updateTask(Task task);
  Future<void> deleteTask(int id);
}
