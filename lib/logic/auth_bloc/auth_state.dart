part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignUpInitial extends AuthState {}

final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {
  final String userName;
  SignUpSuccess({required this.userName});
}

final class SignUpError extends AuthState {
  final String msgError;
  SignUpError({required this.msgError});
}

//------------------------------------------------------------------------------

// 2- signIn Cubit

final class LoginInitial extends AuthState {}

final class LoginSuccess extends AuthState {
  final String userName;

  LoginSuccess({required this.userName});
}

final class LoginLoading extends AuthState {}

final class LoginError extends AuthState {
  final String msgError;

  LoginError({required this.msgError});
}
