part of 'assetpartfunctioning_bloc.dart';

class AssetpartfunctioningState extends Equatable {
  const AssetpartfunctioningState({required this.newValues});
  final List<String> newValues;

  @override
  List<Object> get props => [newValues];

  @override
  bool operator ==(Object other) {
    return other is AssetpartfunctioningState &&
        !listEquals(newValues, other.newValues);
  }
}
