import 'package:task_manager_krainet/core/usecase/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager_krainet/domain/repositories/auth_repository.dart';

class SignIn implements UseCase<UserCredential, SignInParams> {
  SignIn(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<UserCredential> call(SignInParams params) async {
    return await authRepository.login(params.email, params.password);
  }
}

class SignInParams {
  SignInParams({required this.email, required this.password});

  final String email;
  final String password;
}
