import 'package:flutter/material.dart';

Widget rightMessageWidget(message){
  return Container(
    padding:
    const EdgeInsets.only(left: 50, right: 14, top: 10, bottom: 10),
    child: Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.grey.shade200,
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