import 'package:flutter/material.dart';

class Utils {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackbar({
    required String message,
  }) {
    final snackbar = SnackBar(
      content: Text(message),
    );
    scaffoldMessengerKey.currentState!.showSnackBar(snackbar);
  }
}
