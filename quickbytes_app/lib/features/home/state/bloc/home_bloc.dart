import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:meta/meta.dart';
import 'package:news_repository/news_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {}

  @override
  Future<void> close() {
    print("Home Bloc Closed!!!");
    return super.close();
  }
}
