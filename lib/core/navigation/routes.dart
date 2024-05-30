import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:quickbytes_app/features/auth/presentation/pages/login_page.dart';
import 'package:quickbytes_app/features/base/presentation/pages/base_page.dart';
import 'package:quickbytes_app/features/base/state/app_bloc.dart';
import 'package:quickbytes_app/features/home/presentation/pages/home_page.dart';
import 'package:quickbytes_app/features/news/presentation/pages/news_page.dart';
import 'package:quickbytes_app/features/news/presentation/pages/relevancy_page.dart';
import 'package:quickbytes_app/features/profile/presentation/pages/profile_page.dart';
import 'package:quickbytes_app/features/search/presentation/pages/search_page.dart';
import 'package:quickbytes_app/features/settings/presentation/pages/preferences/user_preferences_page.dart';
import 'package:quickbytes_app/features/settings/presentation/pages/settings_page.dart';

part 'routes.g.dart';

// generation command
// dart pub run build_runner build

@TypedGoRoute<BasePageRoute>(
  path: '/',
  routes: [
    TypedGoRoute<ProfilePageRoute>(path: 'profile'),
    // TypedGoRoute<AuthPageRoute>(path: 'auth'),
    TypedGoRoute<SearchPageRoute>(path: 'search'),
    TypedGoRoute<HomePageRoute>(
      path: 'home',
      routes: [
        TypedGoRoute<RelevancyPageRoute>(path: 'relevancy'),
        TypedGoRoute<UserPreferencesHomePageRoute>(path: 'preferences'),
        TypedGoRoute<SettingsPageRoute>(
          path: 'settings',
          routes: [
            TypedGoRoute<UserPreferencesSettingsPageRoute>(path: 'preferences'),
          ],
        ),
      ],
    ),
  ],
)
@immutable
class BasePageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BasePage();
  }
}

@immutable
class HomePageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@immutable
class RelevancyPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RelevancyPage();
  }
}

@immutable
class ProfilePageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfilePage();
  }
}

@immutable
class SettingsPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

@immutable
class SearchPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchPage();
  }
}

@immutable
class UserPreferencesHomePageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UserPreferencesPage();
  }
}

@immutable
class UserPreferencesSettingsPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UserPreferencesPage();
  }
}
