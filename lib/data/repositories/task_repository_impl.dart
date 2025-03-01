import 'package:task_manager_krainet/data/datasources/task_local_data_source.dart';
import 'package:task_manager_krainet/data/models/task_model.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this.taskLocalDataSource);

  final TaskLocalDataSource taskLocalDataSource;

  @override
  Future<void> addTask(Task task) async {
    final taskModel = TaskModel(
        title: task.title,
        description: task.description,
        category: task.category,
        date: task.date,
        isCompleted: task.isCompleted);
    await taskLocalDataSource.saveTask(taskModel);
  }
}
