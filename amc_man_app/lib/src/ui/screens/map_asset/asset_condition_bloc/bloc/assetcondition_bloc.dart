import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'assetcondition_event.dart';
part 'assetcondition_state.dart';

class AssetconditionBloc
    extends Bloc<AssetconditionEvent, AssetconditionState> {
  AssetconditionBloc() : super(const AssetconditionState(newValue: ''));

  Stream<AssetconditionState> mapEventToState(
    AssetconditionEvent event,
  ) async* {
    yield AssetconditionState(newValue: event.newValue);
  }
}
