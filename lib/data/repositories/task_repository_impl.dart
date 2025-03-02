import 'package:task_manager_krainet/data/datasources/task_local_data_source.dart';
import 'package:task_manager_krainet/data/models/task_model.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this.taskLocalDataSource);

  final TaskLocalDataSource taskLocalDataSource;

  @override
  Future<int> addTask(Task task) async {
    final taskModel = TaskModel(
        title: task.title,
        description: task.description,
        category: task.category,
        date: task.date,
        isCompleted: task.isCompleted);
    return await taskLocalDataSource.saveTask(taskModel);
  }

  @override
  Future<List<Task>> getTasks(TaskCategory category) async {
    final List<TaskModel> taskModels =
        await taskLocalDataSource.getTasks(category);
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
  Future<int> updateTask(Task task) async {
    final taskModel = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        category: task.category,
        date: task.date,
        isCompleted: task.isCompleted);
    return await taskLocalDataSource.updateTask(taskModel);
  }

  @override
  Future<void> deleteTask(int id) async {
    return await taskLocalDataSource.deleteTask(id);
  }
}
