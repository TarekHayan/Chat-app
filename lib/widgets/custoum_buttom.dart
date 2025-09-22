import 'package:chat_app/contsts.dart';
import 'package:flutter/material.dart';

class Custoumbuttom extends StatelessWidget {
  const Custoumbuttom({super.key, required this.buttomName, this.onTap});
  final String buttomName;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: kPrimyColor,
        ),
        child: Center(
          child: Text(
            buttomName,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
