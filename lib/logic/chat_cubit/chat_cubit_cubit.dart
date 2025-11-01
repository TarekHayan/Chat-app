import 'package:bloc/bloc.dart';
import 'package:chat_app/contsts.dart';
import 'package:chat_app/models/get_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_cubit_state.dart';

class ChatCubit extends Cubit<ChatCubitState> {
  ChatCubit() : super(ChatCubitInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kFbcolliction,
  );
  List<GetMessages> messagesList = [];
  void sendMasseage({required String userName, required String masseage}) {
    messages.add({'id': userName, 'message': masseage, 'time': DateTime.now()});
  }

  void getMasseage() {
    messages.orderBy("time", descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(GetMessages.fromJasonData(doc));
      }
      emit(ChatCubitSucess(messages: messagesList));
    });
  }
}
