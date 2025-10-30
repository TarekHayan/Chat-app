import 'package:bloc/bloc.dart';
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
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(LoginError(msgError: 'invalid-email'));
      }
      if (e.code == 'invalid-credential') {
        emit(LoginError(msgError: 'invalid-credential'));
      }
      if (e.code == 'user-disabled') {
        emit(LoginError(msgError: 'user-disabled'));
      }
    } catch (e) {
      emit(LoginError(msgError: "something was error"));
    }
  }
}
