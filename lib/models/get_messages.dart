import 'package:cloud_firestore/cloud_firestore.dart';

class GetMessages {
  final DateTime time;
  final String message;
  final String username;

  GetMessages(this.message, this.time, this.username);

  factory GetMessages.fromJasonData(jason) {
    return GetMessages(
      jason['message'],
      (jason['time'] as Timestamp).toDate(),
      jason['id'],
    );
  }
}
