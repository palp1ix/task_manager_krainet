part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class Authorized extends AuthState {
  const Authorized(this.user);

  final User user;
}

final class AuthInProgress extends AuthState {}

final class AuthFailed extends AuthState {}

final class SyncFailed extends AuthState {}

final class Unauthorized extends AuthState {}
