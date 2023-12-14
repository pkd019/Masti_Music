part of 'assetmap_bloc.dart';

abstract class AssetmapState extends Equatable {
  const AssetmapState();

  @override
  List<Object> get props => [];
}

class AssetmapInitial extends AssetmapState {}

class AssetmapSuccess extends AssetmapState {}

class AssetmapInProgress extends AssetmapState {}

class AssetmapFailure extends AssetmapState {
  const AssetmapFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
