import 'package:task_manager_krainet/core/usecase/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager_krainet/domain/repositories/auth_repository.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

class SignIn implements UseCase<UserCredential, SignInParams> {
  SignIn(this.authRepository, this.taskRepository);

  final AuthRepository authRepository;
  final TaskRepository taskRepository;

  @override
  Future<UserCredential> call(SignInParams params) async {
    final userCredential = await authRepository.login(params.email, params.password);
    
    // After successful login, sync local tasks to remote
    await taskRepository.syncLocalTasksToRemote();
    
    return userCredential;
  }
}

class SignInParams {
  SignInParams({required this.email, required this.password});

  final String email;
  final String password;
}
