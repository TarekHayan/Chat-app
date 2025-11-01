part of 'chat_cubit_cubit.dart';

@immutable
sealed class ChatCubitState {}

final class ChatCubitInitial extends ChatCubitState {}

final class ChatCubitSucess extends ChatCubitState {
  final List<GetMessages> messages;

  ChatCubitSucess({required this.messages});
}
