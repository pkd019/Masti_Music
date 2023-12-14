class ImmovableAssetType {
  const ImmovableAssetType(
      {required this.classType,
      required this.subClassType,
      required this.subClassOptionType});

  final String classType;
  final String subClassType;
  final String subClassOptionType;

  ImmovableAssetType.fromJson(Map<String, dynamic> json)
      : classType = json['classType'],
        subClassType = json['subClassType'],
        subClassOptionType = json['subClassOptionType'];

  Map<String, dynamic> toJson() {
    return {
      'classType': classType,
      'subClassType': subClassType,
      'subClassOptionType': subClassOptionType,
    };
  }
}
