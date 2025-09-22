import 'package:chat_app/helper/ShowSnakBar.dart';
import 'package:chat_app/screens/firstPadge.dart';
import 'package:chat_app/screens/logInScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    super.initState();
    // if user login last time
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // check is this user still login in database
        final snapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          try {
            await user.getIdToken(true);
            Navigator.pushNamed(context, Firstpadge.id);
          } on FirebaseAuthException catch (e) {
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, Loginscreen.id);
            showSnakBar(
              context,
              masseage: "This account has been disabled by an administrator.",
            );
          }
        } else {
          await FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, Loginscreen.id);
          showSnakBar(context, masseage: "Please Sigin in  again");
        }
      } else {
        // مش مسجل دخول
        await FirebaseAuth.instance.signOut();
        Navigator.pushNamed(context, Loginscreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()), // شاشة تحميل مؤقتة
    );
  }
}
