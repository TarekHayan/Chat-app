import 'package:chat_app/logic/auth_bloc/auth_bloc.dart';

import '../logic/auth_cubit/auth_cubit.dart'
    hide AuthState, LoginSuccess, LoginError, LoginLoading;
import '../logic/chat_cubit/chat_cubit_cubit.dart';
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
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
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
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
                    Textsfiled(controller: emailController, hitName: 'Email'),
                    SizedBox(height: 8),
                    Textsfiled(
                      controller: passwordController,
                      obscureText: true,
                      hitName: 'password',
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: Custoumbuttom(
                        buttomName: 'Sigin In',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              SignInEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
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
      },
    );
  }
}
