import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> sIgnInUseer({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("No user signed in");

      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      final userName = userDoc['username'];

      emit(LoginSuccess(userName: userName));
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      } else if (e.code == 'invalid-credential') {
        message = 'Incorrect email or password';
      } else if (e.code == 'user-disabled') {
        message = 'This account has been disabled';
      } else {
        message = 'Login failed, please try again';
      }
      emit(LoginError(msgError: message));
    } catch (e) {
      emit(LoginError(msgError: "Something went wrong: $e"));
    }
  }
}
