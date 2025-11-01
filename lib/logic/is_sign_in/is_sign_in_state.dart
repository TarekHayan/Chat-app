part of 'is_sign_in_cubit.dart';

@immutable
sealed class IsSignInState {}

final class IsSignInInitial extends IsSignInState {}

final class IsSignInSuccess extends IsSignInState {
  final String userName;

  IsSignInSuccess({required this.userName});
}

final class IsSignInError extends IsSignInState {}

final class IsSignInLoading extends IsSignInState {}
