import 'package:chat_app/contsts.dart';
import 'package:chat_app/helper/ShowSnakBar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/widgets/custoum_buttom.dart';
import 'package:chat_app/widgets/sign_interface.dart';
import 'package:chat_app/widgets/texts_filed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static String id = 'signUpScreen';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? userName;
  String? email;
  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: progress,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 100),
                SignInterface(),
                SizedBox(height: 150),
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                SizedBox(height: 15),
                Textsfiled(
                  hitName: 'User Name',
                  onChanged: (data) {
                    userName = data.replaceAll(" ", '').toLowerCase();
                  },
                ),
                SizedBox(height: 8),
                Textsfiled(
                  hitName: 'Email',
                  onChanged: (data) {
                    email = data.replaceAll(" ", "");
                  },
                ),

                SizedBox(height: 8),
                Textsfiled(
                  obscureText: true,
                  hitName: 'password',
                  onChanged: (data) {
                    password = data;
                  },
                ),
                SizedBox(height: 50),
                Center(
                  child: Custoumbuttom(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        bool avalib = await cheakUserName(userName!);
                        if (!avalib) {
                          showSnakBar(context, masseage: 'User name not valid');
                          return;
                        }

                        if (!cheak_lenght_user_name(userName!)) {
                          showSnakBar(
                            context,
                            masseage:
                                'User Name Characters Lentgh Must Be Between 5 , 30 ',
                          );
                          return;
                        }

                        try {
                          progress = true;
                          setState(() {});
                          await registerUser(email!, password!, userName!);
                          Navigator.pushNamed(
                            context,
                            ChatPage.id,
                            arguments: userName,
                          );
                          progress = false;
                          setState(() {});
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'invalid-email') {
                            showSnakBar(
                              context,
                              masseage: 'The email address is badly formatted.',
                            );
                          }
                          if (e.code == 'weak-password') {
                            showSnakBar(
                              context,
                              masseage: "The password provided is too weak.",
                            );
                          } else if (e.code == 'email-already-in-use') {
                            showSnakBar(
                              context,
                              masseage:
                                  'The account already exists for that email.',
                            );
                          }
                          progress = false;
                          setState(() {});
                          return;
                        } catch (e) {
                          showSnakBar(context, masseage: 'there was an error');
                          return;
                        }
                        showSnakBar(context, masseage: "register success");
                        progress = false;
                        setState(() {});
                      }
                    },
                    buttomName: 'Sigin Up',
                  ),
                ),
                SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account? ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sigin In',
                        style: TextStyle(color: kPrimyColor, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(
    String email,
    String password,
    String username,
  ) async {
    UserCredential userCred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCred.user;

    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  bool cheak_lenght_user_name(String userName) {
    if (userName.length < 5 || userName.length > 30) {
      return false;
    }
    return true;
  }

  Future<bool> cheakUserName(String userName) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: userName)
        .get();

    return result.docs.isEmpty;
  }
}
