import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/screens/login_page.dart';
import 'package:flutter_socket_chatapp/screens/signup_page.dart';
import 'package:flutter_socket_chatapp/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';

class GreetingPage extends StatelessWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/image.png'),
            Text(
              "Flutter.IO",
              style: GoogleFonts.raleway(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: colors.textColor),
            ),
            Text(
              'Flutter chat app built using Socket.IO',
              style: GoogleFonts.raleway(fontSize: 20, color: colors.textColor),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colors.buttonColor,width: 3.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8.0),
                      child: Text(
                        'LOGIN',
                        style: GoogleFonts.raleway(
                            fontSize: 15, fontWeight: FontWeight.bold,color: colors.alternateButtonTextColor),
                      ),
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
                  style: ElevatedButton.styleFrom(primary: colors.buttonColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8.0),
                    child: Text(
                      'SIGN UP',
                      style: GoogleFonts.raleway(fontSize: 15, fontWeight: FontWeight.bold,color: colors.buttonTextColor),
                    ),
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
