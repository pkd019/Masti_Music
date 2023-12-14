import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'assetfunctioning_event.dart';
part 'assetfunctioning_state.dart';

class AssetfunctioningBloc
    extends Bloc<AssetfunctioningEvent, AssetfunctioningState> {
  AssetfunctioningBloc() : super(const AssetfunctioningState(newValue: ''));

  Stream<AssetfunctioningState> mapEventToState(
    AssetfunctioningEvent event,
  ) async* {
    yield AssetfunctioningState(newValue: event.newValue);
  }
}
