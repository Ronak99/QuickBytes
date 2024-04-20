import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/core/logs/logs.dart';
import 'package:quickbytes_app/core/navigation/app_router.dart';
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
          BlocProvider<ThemeCubit>(
            create: (BuildContext context) => ThemeCubit(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(builder: (
      context,
      themeMode,
    ) {
      return MaterialApp.router(
        themeMode: themeMode,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: appRouter(
          context.select(
            (AppBloc bloc) => bloc.state.status,
          ),
        ),
      );
    });
  }
}
