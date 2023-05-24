import 'package:flutter/material.dart';

class MyMessageHandler {
  static void showSnackbar(var scafoldKey, String message) {
    scafoldKey.currentState!.hideCurrentSnackBar();
    scafoldKey.currentState!.showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.amber,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        )));
  }
}
