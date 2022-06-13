import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_socket_chatapp/screens/greeting_page.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'utils.dart';

Future<http.Response> makeHTTPRequest(body, String route,
    Map<String, dynamic>? queryParameters, attachJWT, isPOST,
    {BuildContext? context}) async {
  try {
    var contentType = {"Content-Type": "application/json"};

    if (attachJWT) {
      contentType["user-auth-token"] = await jwtTokenGet ?? "";
    }

    http.Response res;

    if (isPOST) {
      res = await http
          .post(
              isHTTPS
                  ? Uri.https(networkAddress, route, queryParameters)
                  : Uri.http(networkAddress, route, queryParameters),
              headers: contentType,
              body: body)
          .timeout(
        const Duration(seconds: 25),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response(json.encode({'message': 'Server Timed out!'}),
              408); // Request Timeout response status code
        },
      );
    } else {
      res = await http
          .get(
              isHTTPS
                  ? Uri.https(networkAddress, route, queryParameters)
                  : Uri.http(networkAddress, route, queryParameters),
              headers: contentType)
          .timeout(
        const Duration(seconds: 25),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response(json.encode({'message': 'Server Timed out!'}),
              408); // Request Timeout response status code
        },
      );
    }

    if (res.statusCode == 412) {
      if (context != null) {
        jwtTokenSet = "";
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const GreetingPage()),
            (Route<dynamic> route) => false);
      }
      //TODO: Show something here alerting user
    }

    return res;
  } catch (e) {
    print(e);
    return http.Response(
        json.encode({'message': 'Could not connect to server'}), 408);
  }
}
