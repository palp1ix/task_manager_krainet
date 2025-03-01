import 'package:task_manager_krainet/core/usecase/usecase.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

class AddTask implements UseCase<void, AddTaskParams> {
  AddTask(this.taskRepository);

  final TaskRepository taskRepository;

  @override
  Future<void> call(AddTaskParams params) async {
    await taskRepository.addTask(params.task);
  }
}

class AddTaskParams {
  AddTaskParams({required this.task});

  final Task task;
}
