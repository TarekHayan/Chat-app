import '../contsts.dart';
import 'package:flutter/material.dart';

class Textsfiled extends StatelessWidget {
  const Textsfiled({
    super.key,
    required this.hitName,
    this.onChanged,
    this.obscureText = false,
  });
  final bool obscureText;

  final String hitName;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return 'this field is required';
        }
      },
      onChanged: onChanged,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hint: Text(
          hitName,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: kPrimyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
