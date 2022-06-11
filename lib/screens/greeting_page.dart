import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/screens/login_page.dart';
import 'package:flutter_socket_chatapp/screens/signup_page.dart';

class GreetingPage extends StatelessWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            const Text(
              "Flutter.IO",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Flutter chat app built using Socket.IO',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
