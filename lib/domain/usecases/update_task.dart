import 'package:task_manager_krainet/core/usecase/usecase.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

class UpdateTask implements UseCase<void, UpdateTaskParams> {
  final TaskRepository taskRepository;

  UpdateTask(this.taskRepository);

  @override
  Future<void> call(params) async {
    await taskRepository.updateTask(params.task);
  }
}

class UpdateTaskParams {
  final Task task;

  UpdateTaskParams(this.task);
}
