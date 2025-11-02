import 'package:flutter/material.dart';

import '../contsts.dart';
import '../models/get_messages.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.messages});
  final GetMessages messages;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        decoration: BoxDecoration(
          color: kPrimyColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              messages.message,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 4),
            Text(
              "${messages.time.hour}:${messages.time.minute} ",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubblemyfriend extends StatelessWidget {
  const ChatBubblemyfriend({super.key, required this.messages});
  final GetMessages messages;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        decoration: BoxDecoration(
          color: Color(0xff3c4550),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(messages.username, style: TextStyle(color: kPrimyColor)),
            SizedBox(height: 4),
            Text(
              messages.message,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 4),
            Text(
              "${messages.time.hour}:${messages.time.minute} ",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
