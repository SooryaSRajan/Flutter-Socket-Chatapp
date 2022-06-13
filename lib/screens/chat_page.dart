import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/model/chat_model.dart';
import 'package:flutter_socket_chatapp/widgets/left_chat.dart';
import 'package:flutter_socket_chatapp/widgets/right_chat.dart';

import '../utils/http_modules.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {Key? key,
      required this.userName,
      required this.profileName,
      required this.socket})
      : super(key: key);
  final String userName;
  final String profileName;
  final Socket socket;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isOnline = false;
  String chatId = "";
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatModel> chatList = [];

  setupChats() async {
    var response = await makeHTTPRequest(
        null, "/chats/${widget.userName}", null, true, false);

    if (response.statusCode == 200) {
      var users = json.decode(response.body)['chats'];
      if (users != null) {
        for (var i in users) {
          chatList.add(ChatModel(
              message: i['message'],
              isRightMessage: i['sentBy'] != widget.userName));
        }
        _scrollToBottom();
      }
      chatId = json.decode(response.body)['chatId'];
      print(chatId);
      widget.socket.on(chatId, (data) {
        chatList.add(ChatModel(
            message: data[0], isRightMessage: data[1] != widget.userName));
        setState(() {});
        _scrollToBottom();
      });

      widget.socket.emit('status', widget.userName);
      widget.socket.on(widget.userName, (data) {
        if (data == 'ONLINE') {
          setState(() {
            isOnline = true;
          });
        } else {
          setState(() {
            isOnline = false;
          });
        }
      });
      setState(() {});
    }
  }

  _scrollToBottom() {
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 1000,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupChats();
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
                  controller: _scrollController,
                  itemCount: chatList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var chatData = chatList[index];

                    if (chatData.isRightMessage) {
                      return rightMessageWidget(chatData.message);
                    }
                    return leftMessageWidget(chatData.message);
                  })),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: "Send message...",
                      contentPadding: const EdgeInsets.only(top: 15),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        splashRadius: 20,
                        onPressed: () async {
                          String message = _controller.text;
                          if (message.isNotEmpty) {
                            widget.socket.emit('message', [message, chatId]);
                            _controller.clear();
                            setState(() {
                              chatList.add(ChatModel(
                                  message: message, isRightMessage: true));
                            });
                            _scrollToBottom();
                          }
                        },
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

  @override
  void dispose() {
    super.dispose();
    widget.socket.clearListeners();
  }
}
