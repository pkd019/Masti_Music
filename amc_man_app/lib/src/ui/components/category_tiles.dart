import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../screens/map_asset/asset_map_page.dart';
import '../../models/immovable_asset_type/immovable_asset_type.dart';
import '../../global/globals.dart' as global;

class ClassTile extends StatelessWidget {
  const ClassTile({super.key, required this.classType});

  final String classType;

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: Text(
        classType,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 16.0,
            ),
      ),
      expanded: Builder(
        builder: (context) {
          final List subClasses =
              global.assetHelper.getSubClassFromClass(classType);
          List<SubClassTile> subClassTileList = [];
          for (var element in subClasses) {
            subClassTileList.add(
              SubClassTile(
                subClassType: element.toString(),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AssetMapPage.id,
                    arguments: ImmovableAssetType(
                      classType: classType,
                      subClassType: element,
                      subClassOptionType: '',
                    ),
                  );
                },
              ),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: subClassTileList,
          );
        },
      ),
      theme: ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        tapHeaderToExpand: true,
        iconColor: Theme.of(context).iconTheme.color,
      ),
      collapsed: const Text(''),
    );
  }
}

class SubClassTile extends StatelessWidget {
  final String subClassType;
  final void Function() onTap;

  const SubClassTile(
      {super.key, required this.subClassType, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enableFeedback: true,
      isThreeLine: false,
      minVerticalPadding: 0.0,
      dense: true,
      title: Text(
        subClassType,
        style:
            Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16.0),
      ),
      trailing: const Icon(
        Icons.arrow_forward_rounded,
        size: 20.0,
      ),
      onTap: onTap,
    );
  }
}
