import 'package:chat_app/logic/auth_cubit/auth_cubit.dart';
import 'package:chat_app/logic/chat_cubit/chat_cubit_cubit.dart';

import '../contsts.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static String id = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is IsSignInSuccess) {
          BlocProvider.of<ChatCubit>(context).getMasseage();
          Navigator.pushReplacementNamed(
            context,
            ChatPage.id,
            arguments: state.userName,
          );
        } else if (state is IsSignInError) {
          Navigator.pushReplacementNamed(context, SignInPage.id);
        }
      },
      builder: (context, state) {
        if (state is AuthInitial) {
          context.read<AuthCubit>().isSignInUser();
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(kpimage, width: 120, height: 120),
                SizedBox(height: 10),
                Text(
                  kPname,
                  style: TextStyle(color: kPrimyColor, fontSize: 22),
                ),
                SizedBox(height: 30),
                if (state is IsSignInLoading)
                  CircularProgressIndicator(color: kPrimyColor),
              ],
            ),
          ),
        );
      },
    );
  }
}
