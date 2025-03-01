import 'package:task_manager_krainet/core/usecase/usecase.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

class UpdateTaskUseCase implements UseCase<int, UpdateTaskParams> {
  final TaskRepository taskRepository;

  UpdateTaskUseCase(this.taskRepository);

  @override
  Future<int> call(params) async {
    return await taskRepository.updateTask(params.task);
  }
}

class UpdateTaskParams {
  final Task task;

  UpdateTaskParams(this.task);
}
