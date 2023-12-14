part of 'assetfunctioning_bloc.dart';

class AssetfunctioningState extends Equatable {
  const AssetfunctioningState({required this.newValue});

  final String newValue;
  @override
  List<Object> get props => [newValue];
}
