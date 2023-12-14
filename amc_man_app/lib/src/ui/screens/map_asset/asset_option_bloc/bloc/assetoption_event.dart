part of 'assetoption_bloc.dart';

class AssetoptionEvent extends Equatable {
  const AssetoptionEvent({required this.newValue});

  final String newValue;

  @override
  List<Object> get props => [newValue];
}
