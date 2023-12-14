import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'assetoption_event.dart';
part 'assetoption_state.dart';

class AssetoptionBloc extends Bloc<AssetoptionEvent, AssetoptionState> {
  AssetoptionBloc() : super(const AssetoptionState(newValue: ''));

  Stream<AssetoptionState> mapEventToState(
    AssetoptionEvent event,
  ) async* {
    yield AssetoptionState(newValue: event.newValue);
  }
}
