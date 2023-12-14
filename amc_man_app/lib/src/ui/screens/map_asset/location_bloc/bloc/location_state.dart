import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class LocationState extends Equatable {
  const LocationState._({
    required this.location,
    this.errorMessage,
    this.infoMessage = 'Capture Location',
  });

  const LocationState.inProgress() : this._(location: null);
  const LocationState.locationCaptured(Position location)
      : this._(location: location);
  const LocationState.failure(String message)
      : this._(location: null, errorMessage: message);

  final Position? location;
  final String? errorMessage;
  final String infoMessage;

  @override
  List<Object?> get props => [location, errorMessage, infoMessage];
}
