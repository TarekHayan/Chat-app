import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
            return const ChatPage();
          } else {
            return SignInPage();
          }
        },
      ),
    );
  }
}
