import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quickbytes_app/core/logs/logs.dart';
import 'package:quickbytes_app/shared/utils/constants.dart';
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
    String body = '''

App Version: ${AppConfig.version}, Patch: ${AppConfig.patch}
Operating System: ${Platform.operatingSystem}, 
OS Version: ${Platform.operatingSystemVersion}
------------------

Hello Quickbytes team,

I would like to''';

    String uriString =
        "mailto:$contactEmail?subject=Quickbytes Feedback&body=$body";

    Uri uri = Uri.parse(uriString);

    handleUrlExternally(uri);
  }

  static void handleUrlExternally(Uri uri) async {
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      Logger.instance.e(e.toString());
    }
  }

  static String extractDomain(String url) {
    Uri uri = Uri.parse(url);
    String domain = uri.host;

    // Remove the 'www.' prefix if present
    if (domain.startsWith("www.")) {
      domain = domain.substring(4);
    }

    return domain;
  }
}
