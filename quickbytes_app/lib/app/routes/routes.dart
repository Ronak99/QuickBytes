import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:quickbytes_app/ui/pages/home/view/home_page.dart';
import 'package:quickbytes_app/ui/pages/login/view/login_page.dart';
import 'package:quickbytes_app/ui/pages/settings/settings_page.dart';

part 'routes.g.dart';

@TypedGoRoute<HomePageRoute>(path: '/')
@immutable
class HomePageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@TypedGoRoute<LoginPageRoute>(path: '/login')
@immutable
class LoginPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

@TypedGoRoute<SettingsPageRoute>(path: '/settings')
@immutable
class SettingsPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}
