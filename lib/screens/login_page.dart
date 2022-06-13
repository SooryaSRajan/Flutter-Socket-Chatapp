import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/screens/home_page.dart';
import 'package:flutter_socket_chatapp/screens/signup_page.dart';
import 'package:flutter_socket_chatapp/utils/http_modules.dart';

import '../utils/utils.dart';
import '../widgets/error_box.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? userName, password;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container()),
              const Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextFormField(
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Username cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    userName = value;
                  },
                  decoration: const InputDecoration(
                      labelText: "User Name",
                      hintText: "Enter user name, eg: john_myers",
                      filled: true,
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Password cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    password = value;
                  },
                  decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your password here",
                      filled: true,
                      border: OutlineInputBorder()),
                ),
              ),
              errorBox(error),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      child: const Text("Don't have an account? Sign up"))),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      error = "";
                    });
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      var response = await makeHTTPRequest(
                          json.encode(
                              {"userName": userName, "password": password}),
                          "/auth/login",
                          null,
                          false,
                          true);

                      if (response.statusCode == 200) {
                        jwtTokenSet = json.decode(response.body)['token'];
                        setProfileName =
                            json.decode(response.body)['profileName'];
                        if (!mounted) return;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (Route<dynamic> route) => false);
                      } else {
                        setState(() {
                          error = json.decode(response.body)['message'];
                        });
                      }
                    }
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
