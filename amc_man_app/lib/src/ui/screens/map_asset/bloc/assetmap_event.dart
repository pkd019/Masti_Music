part of 'assetmap_bloc.dart';

abstract class AssetmapEvent extends Equatable {
  const AssetmapEvent();

  @override
  List<Object> get props => [];
}

class UploadAsset extends AssetmapEvent {
  const UploadAsset({
    required this.context,
    required this.assetClass,
    required this.assetSubClass,
    required this.assetSubClassOption,
    required this.name,
    required this.description,
    required this.location,
    required this.functioning,
    required this.assetPartFuncReason,
    required this.physicalCondition,
    required this.assetLocalFilePath,
  });

  final AssetLocation location;
  final String assetClass;
  final String assetSubClass;
  final String assetSubClassOption;
  final String name;
  final String description;
  final String functioning;
  final String physicalCondition;
  final List<String> assetPartFuncReason;
  final List<String> assetLocalFilePath;
  final BuildContext context;
  @override
  List<Object> get props => [
        context,
        assetClass,
        assetSubClass,
        assetSubClassOption,
        name,
        description,
        location,
        functioning,
        assetPartFuncReason,
        physicalCondition,
        assetLocalFilePath,
      ];
}
