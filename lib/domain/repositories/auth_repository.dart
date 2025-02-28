import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRepository {
  Future<UserCredential> login(String email, String password);
}
