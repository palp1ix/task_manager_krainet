import 'package:task_manager_krainet/core/usecase/usecase.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

class GetTaskList implements UseCase<List<Task>, GetTaskListParams> {
  GetTaskList(this.taskRepository);

  final TaskRepository taskRepository;

  @override
  Future<List<Task>> call(GetTaskListParams params) async {
    return await taskRepository
        .getTasks(TaskCategory.fromString(params.category));
  }
}

class GetTaskListParams {
  GetTaskListParams({required this.category});

  final String category;
}
