import 'package:flutter/widgets.dart';
import 'package:quickbytes_app/app/app.dart';
import 'package:quickbytes_app/home/home.dart';
import 'package:quickbytes_app/login/view/login_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
