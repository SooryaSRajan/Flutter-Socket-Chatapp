import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/screens/greeting_page.dart';
import 'package:flutter_socket_chatapp/screens/home_page.dart';
import 'package:flutter_socket_chatapp/utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: jwtTokenGet,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasError) {
            if (snapshot.hasData) {
              return const HomePage();
            }
          }
          return const GreetingPage();
        },
      ),
    );
  }
}
