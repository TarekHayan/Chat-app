import '../logic/chat_cubit/chat_cubit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../contsts.dart';
import '../helper/ShowSnakBar.dart';
import '../models/get_messages.dart';
import 'sign_in_page.dart';
import '../widgets/chat_babble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static String id = 'firstPadge';
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var userName = ModalRoute.of(context)!.settings.arguments;

    String? masseage;

    final ScrollController scrollController = ScrollController();

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
                MaterialPageRoute(builder: (context) => SignInPage()),
                (route) => false,
              );
              showSnakBar(context, masseage: "SignOut success");
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
            child: BlocBuilder<ChatCubit, ChatCubitState>(
              builder: (context, state) {
                List<GetMessages> listOfMessages = BlocProvider.of<ChatCubit>(
                  context,
                ).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: listOfMessages.length,
                  itemBuilder: (context, index) {
                    return (listOfMessages[index].username == userName)
                        ? ChatBubble(messages: listOfMessages[index])
                        : ChatBubblemyfriend(messages: listOfMessages[index]);
                  },
                );
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
                masseage = value;
                BlocProvider.of<ChatCubit>(context).sendMasseage(
                  userName: userName as String,
                  masseage: masseage as String,
                );
                controller.clear();
                scrollController.animateTo(
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
                    BlocProvider.of<ChatCubit>(context).sendMasseage(
                      userName: userName as String,
                      masseage: masseage as String,
                    );
                    controller.clear();
                    scrollController.animateTo(
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
  }
}
