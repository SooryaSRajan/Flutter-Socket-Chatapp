import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/screens/home_page.dart';
import 'package:flutter_socket_chatapp/screens/login_page.dart';
import 'package:flutter_socket_chatapp/utils/http_modules.dart';
import 'package:flutter_socket_chatapp/widgets/error_box.dart';
import 'package:flutter_socket_chatapp/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';

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
                "Sign Up",
                style: GoogleFonts.raleway(fontSize: 45, fontWeight: FontWeight.w600,color: colors.textColor),
              ),
              Text(
                "Start chatting with your friends",
                style: GoogleFonts.raleway(fontSize: 20, fontWeight: FontWeight.w600,color: colors.textColor),
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
                  decoration: InputDecoration(
                      labelText: "Profile Name",
                      hintText: "Enter profile name, eg: john_myers",
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
                      hintText: "Enter your password here",
                      filled: true,
                      labelStyle:
                      GoogleFonts.raleway(color: colors.textFIeldTextColor),
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
                            builder: (context) => const LoginPage()));
                  },
                  child: Text("Already have an account? Login",style: GoogleFonts.raleway(color: colors.textColor),)),
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
                  style: ElevatedButton.styleFrom(primary: colors.buttonColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15.0),
                    child: Text(
                      'SIGN UP',
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
