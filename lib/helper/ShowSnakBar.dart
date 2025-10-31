import 'package:flutter/material.dart';

import '../contsts.dart';

void showSnakBar(BuildContext context, {required String masseage}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor: kPrimyColor, content: Text(masseage)),
  );
}
