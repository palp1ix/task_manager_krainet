import 'package:task_manager_krainet/core/usecase/usecase.dart';
import 'package:task_manager_krainet/domain/repositories/auth_repository.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

class LogOut implements UseCase<void, NoParams> {
  LogOut(this.authRepository, this.taskRepository);

  final AuthRepository authRepository;
  final TaskRepository taskRepository;

  @override
  Future<void> call(params) async {
    await taskRepository.syncRemoteTasksToLocal();

    await authRepository.logout();
  }
}
