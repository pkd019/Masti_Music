// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) {
  return Asset(
    uploadedBy: json['uploadedBy'] as String,
    assetClass: json['assetClass'] as String,
    assetSubClass: json['assetSubClass'] as String,
    assetSubClassOption: json['assetSubClassOption'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    assetLocalFilePath: (json['assetLocalFilePath'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    assetLocation:
        AssetLocation.fromJson(json['assetLocation'] as Map<String, dynamic>),
    assetImagesUrl: (json['assetImagesUrl'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    functioning: json['functioning'] as String,
    assetPartFuncReason: (json['assetPartFuncReason'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    physicalCondition: json['physicalCondition'] as String,
  );
}

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'uploadedBy': instance.uploadedBy,
      'assetClass': instance.assetClass,
      'assetSubClass': instance.assetSubClass,
      'assetSubClassOption': instance.assetSubClassOption,
      'name': instance.name,
      'description': instance.description,
      'physicalCondition': instance.physicalCondition,
      'functioning': instance.functioning,
      'assetPartFuncReason': instance.assetPartFuncReason,
      'assetLocalFilePath': instance.assetLocalFilePath,
      'assetLocation': instance.assetLocation.toJson(),
      'assetImagesUrl': instance.assetImagesUrl,
    };

AssetLocation _$AssetLocationFromJson(Map<String, dynamic> json) {
  return AssetLocation(
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    altitude: (json['altitude'] as num).toDouble(),
    heading: (json['heading'] as num).toDouble(),
  );
}

Map<String, dynamic> _$AssetLocationToJson(AssetLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'altitude': instance.altitude,
      'heading': instance.heading,
    };
