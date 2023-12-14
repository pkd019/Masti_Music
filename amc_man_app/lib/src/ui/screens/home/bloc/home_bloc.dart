import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(pageIndex: 0));

  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    switch (event.newIndex) {
      case 0:
        yield const HomeState(pageIndex: 0);
        break;
      case 1:
        yield const HomeState(pageIndex: 1);
        break;
      case 2:
        yield const HomeState(pageIndex: 2);
        break;
      default:
        yield const HomeState(pageIndex: 0);
        break;
    }
  }
}
