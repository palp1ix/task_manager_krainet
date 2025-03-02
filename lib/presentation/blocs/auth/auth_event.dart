part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  AuthSignUp({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class AuthLogout extends AuthEvent {
  @override
  List<Object> get props => [];
}
