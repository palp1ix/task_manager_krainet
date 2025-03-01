import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager_krainet/core/exeptions/exceptions.dart';
import 'package:task_manager_krainet/core/utils/utils.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential> loginWithEmailPassword(String email, String password);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> loginWithEmailPassword(
      String email, String password) async {
    return AppUtils.serverResponseHandler<Future<UserCredential>,
        ServerException>(
      () async {
        try {
          final userCredentials = await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password);

          return userCredentials;
        } on FirebaseAuthException catch (e) {
          throw ServerException(e.message);
        }
      },
      exceptionBuilder: (message) => ServerException(message),
    );
  }

  @override
  Future<void> logout() async {
    return AppUtils.serverResponseHandler<Future<void>, ServerException>(
      () async {
        return await firebaseAuth.signOut();
      },
      exceptionBuilder: (message) => ServerException(message),
    );
  }
}
