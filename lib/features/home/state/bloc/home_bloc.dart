import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:meta/meta.dart';
import 'package:quickbytes_app/core/logs/logs.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<SwitchToNewsPageRequested>(_switchToNewsPage);
  }

  _switchToNewsPage(SwitchToNewsPageRequested event, Emitter<HomeState> emit) {
    state.goToNewsSubpage();
  }

  @override
  Future<void> close() {
    Logger.instance.d("Home Bloc Closed!!!");
    return super.close();
  }
}
