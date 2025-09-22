import 'package:chat_app/contsts.dart';
import 'package:chat_app/models/get_messages.dart';
import 'package:chat_app/screens/loginScreen.dart';
import 'package:chat_app/widgets/cahtbubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static String id = 'firstPadge';
  @override
  Widget build(BuildContext context) {
    CollectionReference messages = FirebaseFirestore.instance.collection(
      kfbcolliction,
    );
    TextEditingController controller = TextEditingController();

    String? masseage;

    final ScrollController _scrollController = ScrollController();
    var userName = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy("time", descending: true).snapshots(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          List<GetMessages> listOfMessages = [];
          for (int i = 0; i < snapShot.data!.docs.length; i++) {
            listOfMessages.add(
              GetMessages.fromJasonData(snapShot.data!.docs[i]),
            );
          }

          //WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Loginscreen()),
                      (route) => false, // يمسح كل الصفحات اللي قبلها
                    );
                  },
                  icon: Icon(Icons.logout, color: kPrimyColor),
                ),
              ],
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(kpimage, height: 50),
                    Text(
                      'Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: listOfMessages.length,
                    itemBuilder: (context, index) {
                      return (listOfMessages[index].username == userName)
                          ? ChatBubble(messages: listOfMessages[index])
                          : ChatBubblemyfriend(messages: listOfMessages[index]);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10, left: 10, bottom: 20),

                  child: TextField(
                    controller: controller,
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      masseage = value;
                    },
                    onSubmitted: (value) async {
                      messages.add({
                        'message': value,
                        'time': DateTime.now(),
                        'id': userName,
                      });
                      controller.clear();
                      _scrollController.animateTo(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },

                    decoration: InputDecoration(
                      hint: Text(
                        "Send Message",
                        style: TextStyle(color: Colors.white),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          messages.add({
                            'id': userName,
                            'message': masseage,
                            'time': DateTime.now(),
                          });
                          controller.clear();
                          _scrollController.animateTo(
                            0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: Icon(Icons.send, color: kPrimyColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: kPrimyColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
