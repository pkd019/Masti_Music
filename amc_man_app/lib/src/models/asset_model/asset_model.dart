import 'package:json_annotation/json_annotation.dart';

part 'asset_model.g.dart';

class Asset {
  const Asset({
    required this.assetClass,
    required this.assetSubClass,
    required this.assetSubClassOption,
    required this.name,
    required this.description,
    required this.assetLocation,
    required this.assetImagesUrl,
    required this.functioning,
    required this.assetPartFuncReason,
    required this.physicalCondition,
    required this.assetLocalFilePath,
    required this.uploadedBy,
  });

  final String uploadedBy;
  final String assetClass;
  final String assetSubClass;
  final String assetSubClassOption;
  final String name;
  final String description;
  final String physicalCondition;
  final String functioning;
  final List<String> assetPartFuncReason;
  final AssetLocation assetLocation;
  final List<String> assetImagesUrl;
  final List<String> assetLocalFilePath;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}

@JsonSerializable()
class AssetLocation {
  const AssetLocation({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.heading,
  });

  final double latitude;
  final double longitude;
  final double altitude;
  final double heading;

  factory AssetLocation.fromJson(Map<String, dynamic> json) =>
      _$AssetLocationFromJson(json);

  Map<String, dynamic> toJson() => _$AssetLocationToJson(this);
}

enum PhysicalCondition { excellent, good, fair, poor, bad, veryBad }

enum AssetFunctioning { working, partial, closed }

final assetPartFunctionReason = [
  'Staff or service irregular',
  'Equipment or supply or infrastructure is insufficient'
];
