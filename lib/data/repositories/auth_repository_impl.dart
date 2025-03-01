import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager_krainet/data/datasources/auth_remote_data_source.dart';
import 'package:task_manager_krainet/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.remoteDataSource);

  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<UserCredential> login(String email, String password) {
    final userCredentials =
        remoteDataSource.loginWithEmailPassword(email, password);
    return userCredentials;
  }
}
