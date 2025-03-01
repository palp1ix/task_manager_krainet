import 'package:task_manager_krainet/core/usecase/usecase.dart';
import 'package:task_manager_krainet/domain/repositories/auth_repository.dart';

class LogOut implements UseCase<void, NoParams> {
  LogOut(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<void> call(params) async {
    await authRepository.logout();
  }
}
