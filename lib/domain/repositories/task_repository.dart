import 'package:task_manager_krainet/domain/entities/task.dart';

abstract interface class TaskRepository {
  Future<int> addTask(Task task);
  Future<List<Task>> getTasks(String category);
  Future<int> updateTask(Task task);
}
