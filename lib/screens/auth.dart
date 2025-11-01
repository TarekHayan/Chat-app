import 'package:chat_app/logic/chat_cubit/chat_cubit_cubit.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});
  static String id = 'Auth';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            BlocProvider.of<ChatCubit>(context).getMasseage();
            return const ChatPage();
          } else {
            return SignInPage();
          }
        },
      ),
    );
  }
}
