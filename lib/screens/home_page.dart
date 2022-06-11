import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/screens/chat_page.dart';

import '../model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> userList = [];

  @override
  void initState() {
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
    userList.add(UserModel(userName: "user_name", profileName: "Name"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter.IO"),
      ),
      body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(userList[index].profileName),
                subtitle: Text(userList[index].userName),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatPage(
                                profileName: userList[index].profileName,
                                userName: userList[index].userName,
                              )));
                },
              ),
            );
          }),
    );
  }
}
