import 'package:amc_man_app/src/models/asset_model/asset_model.dart';
import 'package:amc_man_app/src/route.dart';
import 'package:amc_man_app/src/ui/components/image_widget.dart';
import 'package:flutter/material.dart';

class AssetSummaryPage extends StatelessWidget {
  const AssetSummaryPage({super.key, required this.asset});
  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _AssetSummaryHeadWidget(
                  assetName: asset.name,
                  assetClass: asset.assetClass,
                  assetSubClass: asset.assetSubClass,
                  assetType: asset.assetSubClassOption,
                ),
                const SizedBox(height: 15),
                _AssetSummaryBodyWidget(asset: asset),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AssetSummaryHeadWidget extends StatelessWidget {
  const _AssetSummaryHeadWidget({
    required this.assetName,
    required this.assetClass,
    required this.assetSubClass,
    required this.assetType,
  });

  final String assetName;
  final String assetClass;
  final String assetSubClass;
  final String assetType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            assetName,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 36),
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
          Text(
            '$assetClass / $assetSubClass / $assetType',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 14),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}

class _AssetSummaryBodyWidget extends StatelessWidget {
  const _AssetSummaryBodyWidget({required this.asset});
  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 200,
                child: ImageHolder(
                  child: Image.network(
                    asset.assetImagesUrl[0],
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(
                              strokeWidth: 1.5),
                        );
                      }
                    },
                    fit: BoxFit.contain,
                    semanticLabel: 'asset image',
                  ),
                ),
              ),
            ),
            asset.assetImagesUrl.length > 1
                ? Expanded(
                    child: SizedBox(
                      height: 200,
                      child: ImageHolder(
                        child: Image.network(
                          asset.assetImagesUrl[1],
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 1.5),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  )
                : Expanded(child: Container())
          ],
        ),
        const SizedBox(height: 10.0),
        _AssetSummaryContentHolder(
            title: 'Description', content: asset.description),
        _AssetSummaryContentHolder(
          title: 'Location',
          content:
              'Latitude: ${asset.assetLocation.latitude} Longitude: ${asset.assetLocation.longitude}',
        ),
        _AssetSummaryContentHolder(
            title: 'Physical Condition', content: asset.physicalCondition),
        _AssetSummaryContentHolder(
          title: 'Functioning',
          content: asset.functioning,
        ),
        asset.functioning == (AssetFunctioning.partial).toString().split('.')[1]
            ? _AssetSummaryContentHolder(
                title: 'Reason for partial functioning',
                contentWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: asset.assetPartFuncReason
                      .map((e) => Text('• $e'))
                      .toList(),
                ),
                content: '',
              )
            : Container(),
      ],
    );
  }
}

class _AssetSummaryContentHolder extends StatelessWidget {
  const _AssetSummaryContentHolder({
    required this.title,
    required this.content,
    this.contentWidget,
  });
  final String title;
  final String content;
  final Widget? contentWidget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: contentWidget,
      contentPadding: const EdgeInsets.all(0.0),
      enableFeedback: false,
      isThreeLine: false,
      onTap: null,
      onLongPress: null,
    );
  }
}

class AssetSummaryTile extends StatelessWidget {
  const AssetSummaryTile({super.key, required this.asset});
  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () {
          Navigator.of(context).push(newRoute(AssetSummaryPage(asset: asset)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints.expand(),
                child: Image.network(
                  asset.assetImagesUrl.first,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 1.5,
                          ),
                        ),
                      );
                    }
                  },
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5.0),
                    Text(
                      asset.name,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                    ),
                    Expanded(
                      child: Text(
                        '${asset.assetClass} / ${asset.assetSubClass} / ${asset.assetSubClassOption}',
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
