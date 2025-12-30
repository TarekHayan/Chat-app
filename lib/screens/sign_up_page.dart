import '../logic/auth_cubit/auth_cubit.dart';

import '../logic/chat_cubit/chat_cubit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../contsts.dart';
import '../helper/ShowSnakBar.dart';
import 'chat_page.dart';
import '../widgets/custoum_buttom.dart';
import '../widgets/sign_interface.dart';
import '../widgets/texts_filed.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  static String id = 'signUpScreen';
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is SignUpSuccess) {
          BlocProvider.of<ChatCubit>(context).getMasseage();
          Navigator.pushReplacementNamed(
            context,
            ChatPage.id,
            arguments: state.userName,
          );
        } else if (state is SignUpError) {
          showSnakBar(context, masseage: state.msgError);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignUpLoading,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    SignInterface(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    SizedBox(height: 15),
                    Textsfiled(
                      hitName: 'User Name',
                      controller: userNameController,
                    ),
                    SizedBox(height: 8),
                    Textsfiled(hitName: 'Email', controller: emailController),

                    SizedBox(height: 8),
                    Textsfiled(
                      obscureText: true,
                      hitName: 'password',
                      controller: passwordController,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Center(
                      child: Custoumbuttom(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).registerUser(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              username: userNameController.text.trim(),
                            );
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
      },
    );
  }
}
