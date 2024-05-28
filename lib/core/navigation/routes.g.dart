// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $basePageRoute,
    ];

RouteBase get $basePageRoute => GoRouteData.$route(
      path: '/',
      factory: $BasePageRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'profile',
          factory: $ProfilePageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'search',
          factory: $SearchPageRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'home',
          factory: $HomePageRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'relevancy',
              factory: $RelevancyPageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'preferences',
              factory: $UserPreferencesHomePageRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'settings',
              factory: $SettingsPageRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'preferences',
                  factory:
                      $UserPreferencesSettingsPageRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $BasePageRouteExtension on BasePageRoute {
  static BasePageRoute _fromState(GoRouterState state) => BasePageRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfilePageRouteExtension on ProfilePageRoute {
  static ProfilePageRoute _fromState(GoRouterState state) => ProfilePageRoute();

  String get location => GoRouteData.$location(
        '/profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SearchPageRouteExtension on SearchPageRoute {
  static SearchPageRoute _fromState(GoRouterState state) => SearchPageRoute();

  String get location => GoRouteData.$location(
        '/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HomePageRouteExtension on HomePageRoute {
  static HomePageRoute _fromState(GoRouterState state) => HomePageRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RelevancyPageRouteExtension on RelevancyPageRoute {
  static RelevancyPageRoute _fromState(GoRouterState state) =>
      RelevancyPageRoute();

  String get location => GoRouteData.$location(
        '/home/relevancy',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UserPreferencesHomePageRouteExtension
    on UserPreferencesHomePageRoute {
  static UserPreferencesHomePageRoute _fromState(GoRouterState state) =>
      UserPreferencesHomePageRoute();

  String get location => GoRouteData.$location(
        '/home/preferences',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsPageRouteExtension on SettingsPageRoute {
  static SettingsPageRoute _fromState(GoRouterState state) =>
      SettingsPageRoute();

  String get location => GoRouteData.$location(
        '/home/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UserPreferencesSettingsPageRouteExtension
    on UserPreferencesSettingsPageRoute {
  static UserPreferencesSettingsPageRoute _fromState(GoRouterState state) =>
      UserPreferencesSettingsPageRoute();

  String get location => GoRouteData.$location(
        '/home/settings/preferences',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
