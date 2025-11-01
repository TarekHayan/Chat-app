import 'package:chat_app/logic/chat_cubit/chat_cubit_cubit.dart';

import '../logic/sigin_in_cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../contsts.dart';
import '../helper/ShowSnakBar.dart';
import 'chat_page.dart';
import 'sign_up_page.dart';
import '../widgets/custoum_buttom.dart';
import '../widgets/sign_interface.dart';
import '../widgets/texts_filed.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatelessWidget {
  static String id = 'SignInPage';
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool progress = false;

  SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          progress = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMasseage();
          Navigator.pushReplacementNamed(
            context,
            ChatPage.id,
            arguments: state.userName,
          );
        } else if (state is LoginError) {
          showSnakBar(context, masseage: state.msgError);
        }
      },
      child: ModalProgressHUD(
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
                          BlocProvider.of<LoginCubit>(
                            context,
                          ).sIgnInUseer(email: email!, password: password!);
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
      ),
    );
  }
}
