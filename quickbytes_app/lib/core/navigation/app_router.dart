import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:quickbytes_app/core/error/presentation/error_page.dart';
import 'package:quickbytes_app/core/navigation/routes.dart';
import 'package:quickbytes_app/features/base/state/app_bloc.dart';

// Router Code: https://github.dev/flutter/packages/tree/main/packages/go_router

GoRouter appRouter(AppStatus appStatus) => GoRouter(
      routes: $appRoutes,
      redirect: (BuildContext context, GoRouterState state) {
        switch (appStatus) {
          case AppStatus.authenticated:
            bool isOnAuthPage = state.matchedLocation == "/auth";
            if (isOnAuthPage) {
              return HomePageRoute().location;
            } else {
              return null;
            }

          default:
            return AuthPageRoute().location;
        }
      },
      errorBuilder: (BuildContext context, GoRouterState state) {
        return ErrorPage(
          message: state.error?.message ?? "An error occurred!",
        );
      },
    );
