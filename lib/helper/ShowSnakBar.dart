import 'package:chat_app/contsts.dart';
import 'package:flutter/material.dart';

void showSnakBar(BuildContext context, {required String masseage}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor: kPrimyColor, content: Text(masseage)),
  );
}
