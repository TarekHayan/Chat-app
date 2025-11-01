import 'package:chat_app/logic/chat_cubit/chat_cubit_cubit.dart';
import 'package:chat_app/logic/sign_up_cubit/sign_up_cubit.dart';
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

  String? userName;

  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool progress = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) async {
        if (state is SignUpSuccess) {
          BlocProvider.of<ChatCubit>(context).getMasseage();
          Navigator.pushReplacementNamed(
            context,
            ChatPage.id,
            arguments: state.userName,
          );
        } else if (state is SignUpLoading) {
          progress = true;
        } else if (state is SignUpError) {
          showSnakBar(context, masseage: state.msgError);
        }
      },
      child: ModalProgressHUD(
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
                          BlocProvider.of<SignUpCubit>(context).registerUser(
                            email: email!,
                            password: password!,
                            username: userName!,
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
      ),
    );
  }
}
