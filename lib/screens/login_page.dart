import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/screens/home_page.dart';
import 'package:flutter_socket_chatapp/screens/signup_page.dart';
import 'package:flutter_socket_chatapp/utils/http_modules.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_socket_chatapp/utils/colors.dart' as colors;

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
      backgroundColor: colors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container()),
              Text(
                "Login",
                style: GoogleFonts.raleway(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    color: colors.textColor),
              ),
              Text(
                "Start chatting with your friends!",
                style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: colors.textColor),
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
                  decoration: InputDecoration(
                      labelText: "Username",
                      hintText: "Enter user name, eg: john_myers",
                      filled: true,
                      labelStyle:
                          GoogleFonts.raleway(color: colors.textFIeldTextColor),
                      fillColor: colors.textFieldColor,
                      border: const OutlineInputBorder()),
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
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle:
                          GoogleFonts.raleway(color: colors.textFIeldTextColor),
                      hintText: "Enter your password here",
                      filled: true,
                      fillColor: colors.textFieldColor,
                      border: const OutlineInputBorder()),
                ),
              ),
              errorBox(error),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: Text(
                    "Don't have an account? Sign up",
                    style: GoogleFonts.raleway(color: colors.textColor),
                  )),
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
                  style: ElevatedButton.styleFrom(primary: colors.buttonColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15.0),
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.raleway(fontSize: 15, fontWeight: FontWeight.bold,color: colors.buttonTextColor),
                    ),
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
