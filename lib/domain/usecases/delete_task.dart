import 'package:task_manager_krainet/core/usecase/usecase.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

class DeleteTask implements UseCase<void, DeleteParams> {
  DeleteTask(this.taskRepository);

  final TaskRepository taskRepository;

  @override
  Future<void> call(DeleteParams params) async {
    await taskRepository.deleteTask(params.id);
  }
}

class DeleteParams {
  DeleteParams(this.id);

  final int id;
}
