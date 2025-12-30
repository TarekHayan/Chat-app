import '../contsts.dart';
import 'package:flutter/material.dart';

class SignInterface extends StatelessWidget {
  const SignInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(height: 140, width: 140, child: Image.asset(kpimage)),
        ),
        Center(
          child: Text(
            kPname,
            style: TextStyle(
              fontFamily: 'pacifico',
              color: Colors.white,
              fontSize: 35,
            ),
          ),
        ),
      ],
    );
  }
}
