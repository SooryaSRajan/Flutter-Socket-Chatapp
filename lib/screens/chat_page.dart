import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/model/chat_model.dart';
import 'package:flutter_socket_chatapp/widgets/left_chat.dart';
import 'package:flutter_socket_chatapp/widgets/right_chat.dart';

import '../utils/http_modules.dart';

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
  String chatId = "";

  List<ChatModel> chatList = [];

  getPreviousChats() async {
    var response =
        await makeHTTPRequest(null, "/chats/${widget.userName}", null, true, false);

    print(json.decode(response.body)['message']);
    if (response.statusCode == 200) {
      var users = json.decode(response.body)['chats'];
      for (var i in users) {
        chatList.add(ChatModel(message: i['message'], sentBy: i['sentBy']));
        print(i.toString());
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPreviousChats();
    });
  }

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
                  itemCount: chatList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var chatData = chatList[index];

                    if (chatData.sentBy == widget.userName) {
                      return leftMessageWidget(chatData.message);
                    }
                    return rightMessageWidget(chatData.message);
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
