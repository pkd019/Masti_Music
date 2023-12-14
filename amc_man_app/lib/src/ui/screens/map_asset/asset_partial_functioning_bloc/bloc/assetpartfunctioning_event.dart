part of 'assetpartfunctioning_bloc.dart';

class AssetpartfunctioningEvent extends Equatable {
  const AssetpartfunctioningEvent({required this.newValues});
  final List<String> newValues;

  @override
  List<Object> get props => [newValues];
}
