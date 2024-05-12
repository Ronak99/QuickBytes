import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:quickbytes_app/core/error/presentation/error_page.dart';
import 'package:quickbytes_app/core/navigation/routes.dart';

// Router Code: https://github.dev/flutter/packages/tree/main/packages/go_router

GoRouter get appRouter => GoRouter(
      routes: $appRoutes,
      initialLocation: '/home',
      // redirect: (BuildContext context, GoRouterState state) {
      //   switch (appStatus) {
      //     case AppStatus.authenticated:
      //       bool isOnAuthPage = state.matchedLocation == "/auth";
      //       if (isOnAuthPage) {
      //         return HomePageRoute().location;
      //       } else {
      //         return null;
      //       }

      //     default:
      //       return AuthPageRoute().location;
      //   }
      // },
      errorBuilder: (BuildContext context, GoRouterState state) {
        return ErrorPage(
          message: state.error?.message ?? "An error occurred!",
        );
      },
    );

extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
