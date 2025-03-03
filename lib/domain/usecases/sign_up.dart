import 'package:task_manager_krainet/core/usecase/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager_krainet/domain/repositories/auth_repository.dart';
import 'package:task_manager_krainet/domain/repositories/task_repository.dart';

class SignUp implements UseCase<UserCredential, SignUpParams> {
  SignUp(this.authRepository, this.taskRepository);

  final AuthRepository authRepository;
  final TaskRepository taskRepository;

  @override
  Future<UserCredential> call(SignUpParams params) async {
    final userCredential = await authRepository.register(params.email, params.password);
    
    // After successful registration, sync local tasks to remote
    await taskRepository.syncLocalTasksToRemote();
    
    return userCredential;
  }
}

class SignUpParams {
  SignUpParams({required this.email, required this.password});

  final String email;
  final String password;
}
