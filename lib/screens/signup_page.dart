import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/screens/home_page.dart';
import 'package:flutter_socket_chatapp/screens/login_page.dart';
import 'package:flutter_socket_chatapp/utils/http_modules.dart';
import 'package:flutter_socket_chatapp/widgets/error_box.dart';

import '../utils/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? userName, profileName, password;
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
                "Sign Up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextFormField(
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "User name cannot be empty";
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
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Profile name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    profileName = value;
                  },
                  decoration: const InputDecoration(
                      labelText: "Profile Name",
                      hintText: "Enter profile name, eg: john_myers",
                      filled: true,
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextFormField(
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
                      hintText: "enter your password here",
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
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text("Already have an account? Login"))),
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
                    }
                    var response = await makeHTTPRequest(
                        json.encode({
                          "profileName": profileName,
                          "userName": userName,
                          "password": password
                        }),
                        "/auth/register",
                        null,
                        false,
                        true);

                    if (response.statusCode == 200) {
                      jwtTokenSet = json.decode(response.body)['token'];
                      setProfileName = profileName!;
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
                  },
                  child: const Text(
                    'Sign Up',
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
