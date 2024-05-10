import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quickbytes_app/core/logs/logs.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static void shareApp() {
    const message = '''Hey, check this out! 🤯
This sick new app is perfect for busy people like us. It's got all the need-to-know news in quick, bite-sized bits.
Download QuickBytes now and thank me later! 👌 [insert download link or app store link]''';

    Share.share(message);
  }

  static void userFeedback() async {
    const String contactEmail = "contact@quickbytes.in";
    const String subject = "";
    const String body = "";
    const String uriString = "mailto:$contactEmail?subject=$subject&body=$body";

    Uri uri = Uri.parse(uriString);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      Logger.instance.e(e.toString());
    }
  }
}
