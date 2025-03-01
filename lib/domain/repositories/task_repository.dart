import 'package:task_manager_krainet/domain/entities/task.dart';

abstract interface class TaskRepository {
  Future<void> addTask(Task task);
}
