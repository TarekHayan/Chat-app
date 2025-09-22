import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/firstPadge.dart';
import 'package:chat_app/screens/cheak_user.dart';
import 'package:chat_app/screens/logInScreen.dart';
import 'package:chat_app/screens/signUpScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'CheckUser': (context) => CheckUser(),
        Loginscreen.id: (context) => Loginscreen(),
        Signupscreen.id: (context) => Signupscreen(),
        Firstpadge.id: (context) => Firstpadge(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: 'CheckUser',
    );
  }
}
