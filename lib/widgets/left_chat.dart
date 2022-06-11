import 'package:flutter/material.dart';

Widget leftMessageWidget(message){
  return Container(
    padding:
    const EdgeInsets.only(left: 14, right: 50, top: 10, bottom: 10),
    child: Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.blue[200],
        ),
        padding: const EdgeInsets.all(16),
        child: SelectableText(
          message,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
    ),
  );
}