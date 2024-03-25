import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:quickbytes_app/app/app.dart';
import 'package:quickbytes_app/app/routes/routes.dart';
import 'package:quickbytes_app/ui/pages/error/error_page.dart';

// Router Code: https://github.dev/flutter/packages/tree/main/packages/go_router

GoRouter routerConfig(AppStatus appStatus) => GoRouter(
      routes: $appRoutes,
      redirect: (BuildContext context, GoRouterState state) {
        switch (appStatus) {
          case AppStatus.authenticated:
            return HomePageRoute().location;
          default:
            return LoginPageRoute().location;
        }
      },
      errorBuilder: (BuildContext context, GoRouterState state) {
        return ErrorPage(
          message: state.error?.message ?? "An error occurred!",
        );
      },
    );
