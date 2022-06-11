import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/widgets/left_chat.dart';
import 'package:flutter_socket_chatapp/widgets/right_chat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.userName, required this.profileName})
      : super(key: key);
  final String userName;
  final String profileName;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.profileName),
            Text(
              widget.userName,
              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ],
        ),
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOnline ? Colors.lightGreenAccent : Colors.red,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 16),
                child: Text((isOnline ? "Online" : "Offline")),
              )
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    //TODO: rightMessageWidget(message) and leftMessageWidget("message")
                    return leftMessageWidget("message");
                  })),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Send message...",
                      contentPadding: const EdgeInsets.only(top: 15),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        splashRadius: 20,
                        onPressed: () async {},
                      ),
                      hintStyle: const TextStyle(color: Colors.black54),
                      border: InputBorder.none),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
