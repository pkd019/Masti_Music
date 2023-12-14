import 'package:amc_man_app/src/models/asset_model/asset_model.dart';
import 'package:amc_man_app/src/sdk/asset_functions.dart';
import 'package:amc_man_app/src/ui/components/asset_view.dart';
import 'package:amc_man_app/src/ui/components/no_asset_widget.dart';
import 'package:flutter/material.dart';

class ViewAssetsPage extends StatelessWidget {
  const ViewAssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final assetFunc = AssetFunction(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            _ViewAssetsPageHeader(),
            const Spacer(),
            Expanded(
              flex: 25,
              child: FutureBuilder<List<Asset>>(
                future: assetFunc.getAllAssets(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  } else {
                    switch (snapshot.connectionState) {
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      case ConnectionState.done:
                        if (snapshot.data!.isNotEmpty) {
                          final assetList = snapshot.data;
                          return GridView.builder(
                            itemCount: assetList!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                            ),
                            itemBuilder: (context, index) {
                              return AssetSummaryTile(asset: assetList[index]);
                            },
                          );
                        } else {
                          return const NoAssetWidget();
                        }
                      case ConnectionState.none:
                      default:
                        return Container();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewAssetsPageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assets',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 54),
          ),
          Text(
            'View all uploaded assets',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
