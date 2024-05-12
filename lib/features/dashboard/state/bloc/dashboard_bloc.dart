import 'package:flutter/widgets.dart';
import 'package:news_repository/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState());

  final ScrollController scrollController = ScrollController();

  initialize({required VoidCallback onReachingEndOfTheList}) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        onReachingEndOfTheList();
      }
    });
  }
}
