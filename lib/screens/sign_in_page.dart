import 'package:chat_app/contsts.dart';
import 'package:chat_app/helper/ShowSnakBar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/sign_up_page.dart';
import 'package:chat_app/widgets/custoum_buttom.dart';
import 'package:chat_app/widgets/sign_interface.dart';
import 'package:chat_app/widgets/texts_filed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static String id = 'Loginscreen';
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 100),
                SignInterface(),
                SizedBox(height: 150),
                Text(
                  'Sign In',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                SizedBox(height: 15),
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
                    buttomName: 'Sigin In',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          progress = true;
                          setState(() {});
                          await sIgnInUseer();
                          String userName = await getUserName();
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
                            progress = false;
                            setState(() {});
                          }
                          if (e.code == 'invalid-credential') {
                            showSnakBar(
                              context,
                              masseage: 'email or password are not correct',
                            );
                            progress = false;
                            setState(() {});
                          }
                          if (e.code == 'user-disabled') {
                            showSnakBar(
                              context,
                              masseage:
                                  'This account has been disabled by an administrator.',
                            );
                            progress = false;
                            setState(() {});
                          }
                        } catch (e) {
                          showSnakBar(context, masseage: 'there was an error');
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont have an account? ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpPage.id);
                      },
                      child: Text(
                        'Sign Up',
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

  Future<void> sIgnInUseer() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }

  Future<String> getUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user is currently signed in.');
    }
    DocumentSnapshot docs = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    // You can return a field from docs if needed, for example:
    // return docs['username'];
    return docs['username'];
  }
}
