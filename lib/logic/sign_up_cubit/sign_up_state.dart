part of 'sign_up_cubit.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final String userName;
  SignUpSuccess({required this.userName});
}

final class SignUpError extends SignUpState {
  final String msgError;
  SignUpError({required this.msgError});
}
