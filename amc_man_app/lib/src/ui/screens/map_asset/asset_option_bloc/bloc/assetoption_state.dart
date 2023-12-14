part of 'assetoption_bloc.dart';

class AssetoptionState extends Equatable {
  const AssetoptionState({required this.newValue});

  final String newValue;

  @override
  List<Object> get props => [newValue];
}
