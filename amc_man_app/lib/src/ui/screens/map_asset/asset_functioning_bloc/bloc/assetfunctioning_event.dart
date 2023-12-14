part of 'assetfunctioning_bloc.dart';

class AssetfunctioningEvent extends Equatable {
  const AssetfunctioningEvent({required this.newValue});

  final String newValue;
  @override
  List<Object> get props => [newValue];
}
