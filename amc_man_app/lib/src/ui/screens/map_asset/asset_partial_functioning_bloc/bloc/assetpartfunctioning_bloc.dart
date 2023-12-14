import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'assetpartfunctioning_event.dart';
part 'assetpartfunctioning_state.dart';

class AssetpartfunctioningBloc
    extends Bloc<AssetpartfunctioningEvent, AssetpartfunctioningState> {
  AssetpartfunctioningBloc()
      : super(const AssetpartfunctioningState(newValues: []));

  Stream<AssetpartfunctioningState> mapEventToState(
    AssetpartfunctioningEvent event,
  ) async* {
    yield AssetpartfunctioningState(newValues: event.newValues);
  }
}
