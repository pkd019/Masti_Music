// ignore_for_file: override_on_non_overriding_member

import 'dart:async';

import 'package:amc_man_app/src/global/location_handler.dart';
import 'package:amc_man_app/src/ui/screens/map_asset/location_bloc/bloc/location_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';

class LocationBloc extends Bloc<LocationRequested, LocationState> {
  LocationBloc() : super(const LocationState.inProgress());

  @override
  Stream<LocationState> mapEventToState(LocationRequested event) async* {
    try {
      yield const LocationState.inProgress();
      final locationHandler = LocationHandler();
      final Position location = await locationHandler.getCurrentLocation();

      final String formattedLocation =
          'Latitude: ${location.latitude}, Longitude: ${location.longitude}';
      yield LocationState.locationCaptured(formattedLocation as Position);
    } on NoSuchMethodError catch (e) {
      yield LocationState.failure(e.toString());
    } on TimeoutException catch (e) {
      yield LocationState.failure(e.message.toString());
    } on FormatException catch (e) {
      yield LocationState.failure(e.message);
    } on PlatformException catch (e) {
      yield LocationState.failure(e.message ?? 'Error: Platform Exception');
    } on Exception catch (e) {
      yield LocationState.failure(e.toString());
    }
  }
}
