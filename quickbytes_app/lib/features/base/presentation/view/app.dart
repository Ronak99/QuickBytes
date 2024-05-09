import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/core/logs/logs.dart';
import 'package:quickbytes_app/core/navigation/app_router.dart' as router;
import 'package:quickbytes_app/features/categories/state/cubit/news_category_cubit.dart';
import 'package:quickbytes_app/features/dashboard/state/bloc/dashboard_bloc.dart';
import 'package:quickbytes_app/features/settings/state/bloc/settings_bloc.dart';
import 'package:quickbytes_app/shared/utils/utils.dart';
import 'package:quickbytes_app/features/home/state/bloc/home_bloc.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';
import 'package:quickbytes_app/features/notifications/state/notifications_bloc.dart';
import 'package:quickbytes_app/core/theme/data/app_theme.dart';
import 'package:quickbytes_app/core/theme/state/theme_cubit.dart';

import '../../state/app_bloc.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    required NewsRepository newsRepository,
    super.key,
  })  : _authenticationRepository = authenticationRepository,
        _newsRepository = newsRepository;

  final AuthenticationRepository _authenticationRepository;
  final NewsRepository _newsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (BuildContext context) => AppBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc(),
          ),
          BlocProvider<NewsBloc>(
            create: (BuildContext context) => NewsBloc(
              newsRepository: _newsRepository,
            ),
          ),
          BlocProvider<NotificationsBloc>(
            create: (BuildContext context) => NotificationsBloc(),
          ),
          BlocProvider<NewsCategoryCubit>(
            create: (BuildContext context) => NewsCategoryCubit(
              newsRepository: _newsRepository,
            ),
          ),
          BlocProvider<ThemeCubit>(
            create: (BuildContext context) => ThemeCubit(),
          ),
          BlocProvider<DashboardBloc>(
            create: (BuildContext context) => DashboardBloc(),
          ),
          BlocProvider<SettingsBloc>(
            create: (BuildContext context) => SettingsBloc(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late GoRouter appRouter;

  @override
  void initState() {
    super.initState();
    appRouter = router.appRouter;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (
        context,
        themeMode,
      ) {
        return MaterialApp.router(
          themeMode: themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          scaffoldMessengerKey: Utils.scaffoldMessengerKey,
          routeInformationProvider: appRouter.routeInformationProvider,
          routeInformationParser: appRouter.routeInformationParser,
          routerDelegate: appRouter.routerDelegate,
        );
      },
    );
  }
}
