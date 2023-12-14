import 'dart:convert';

import 'package:flutter/widgets.dart';

class AssetHelper {
  Map<String, dynamic> _assetsData = {};

  Future<void> loadData(BuildContext context) async {
    final stringData =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');
    final Map<String, dynamic> jsonData = jsonDecode(stringData);
    _assetsData = jsonData;
  }

  Map<String, dynamic> get getData => _assetsData;

  List get getClasses => _assetsData['class'] as List;
  Map<String, dynamic> get getSubClasses => _assetsData['subClass'];
  Map<String, dynamic> get getSubClassOptions => _assetsData['subClassOptions'];

  List getSubClassFromClass(String className) {
    final list = _assetsData['subClass'][className] as List;
    return list;
  }

  List getOptionsFromSubClass(String subClass) {
    final list = _assetsData['subClassOptions'][subClass] as List;
    return list;
  }
}
