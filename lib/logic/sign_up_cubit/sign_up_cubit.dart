import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> registerUser({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(SignUpLoading());
    try {
      if (!checkUserNameLength(username)) {
        emit(
          SignUpError(
            msgError: 'User Name Characters Length Must Be Between 5 and 30.',
          ),
        );
        return;
      }
      if (!await checkUserName(username)) {
        emit(SignUpError(msgError: 'User Name Already Exists.'));
        return;
      }
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCred.user;
      if (user == null) throw Exception("User not created");

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(SignUpSuccess(userName: username));
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'invalid-email') {
        message = 'Invalid email address.';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email already in use.';
      } else {
        message = 'Something went wrong.';
      }
      emit(SignUpError(msgError: message));
    } catch (e) {
      emit(SignUpError(msgError: e.toString()));
    }
  }

  Future<bool> checkUserName(String userName) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: userName)
        .get();
    return result.docs.isEmpty;
  }

  bool checkUserNameLength(String userName) {
    return userName.length >= 5 && userName.length <= 30;
  }
}
