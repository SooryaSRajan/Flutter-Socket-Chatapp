import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/screens/chat_page.dart';
import 'package:flutter_socket_chatapp/screens/greeting_page.dart';
import 'package:flutter_socket_chatapp/utils/http_modules.dart';
import 'package:flutter_socket_chatapp/utils/utils.dart';

import '../model/user_model.dart';
import '../widgets/alert_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> userList = [];

  getUserList() async {
    var response =
        await makeHTTPRequest(null, "/user/users", null, true, false);

    if (response.statusCode == 200) {
      var users = json.decode(response.body)['users'];
      for (var i in users) {
        userList.add(
            UserModel(userName: i['userName'], profileName: i['profileName']));
      }
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Flutter.IO"),
              FutureBuilder(
                future: getProfileName,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Text(
                    snapshot.data ?? "",
                    style: const TextStyle(color: Colors.white54, fontSize: 14),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              displayDialog(
                  title: 'Log Out',
                  context: context,
                  subTitle: 'Are you sure you want log out of your account?',
                  negativeText: 'No',
                  positiveText: 'Yes',
                  positiveFunction: () {
                    clearAllData();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GreetingPage()),
                        (Route<dynamic> route) => false);
                  });
            },
            icon: const Icon(Icons.login),
            splashRadius: 20,
          )
        ],
      ),
      body: userList.isNotEmpty
          ? ListView.builder(
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
              })
          : const Center(
              child: Text("No users so far"),
            ),
    );
  }
}
