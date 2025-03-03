import 'package:task_manager_krainet/domain/entities/task_category.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

/// UseCase to retrieve the number of tasks for a specific category
///
/// This follows the Clean Architecture principle where use cases represent
/// application-specific business rules
class CountTasksByCategory {
  final TaskRepository _taskRepository;

  /// Constructor requiring TaskRepository dependency
  CountTasksByCategory(this._taskRepository);

  /// Execute the use case to get the count of tasks for a specific category
  ///
  /// @param category The category for which to count tasks
  /// @return A Future containing the number of tasks in the specified category
  Future<int> call(TaskCategory category) async {
    final tasks = await _taskRepository.getTasks(category);
    return tasks.length;
  }
}