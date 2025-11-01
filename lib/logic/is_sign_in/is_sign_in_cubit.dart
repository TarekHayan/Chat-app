import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'is_sign_in_state.dart';

class IsSignInCubit extends Cubit<IsSignInState> {
  IsSignInCubit() : super(IsSignInInitial());

  void checkUser() async {
    emit(IsSignInLoading());

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(IsSignInError());
      return;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    final userName = userDoc['username'];

    emit(IsSignInSuccess(userName: userName));
  }
}
