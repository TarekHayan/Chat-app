part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {
  final String userName;

  LoginSuccess({required this.userName});
}

final class LoginLoading extends LoginState {}

final class LoginError extends LoginState {
  final String msgError;

  LoginError({required this.msgError});
}
