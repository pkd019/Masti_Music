import 'package:flutter/material.dart';

import '../../components/no_asset_widget.dart';

class SendPage extends StatelessWidget {
  const SendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            _SendPageHeader(),
            const Spacer(),
            const Expanded(
              flex: 25,
              child: NoAssetWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SendPageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Send Assets',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 54),
          ),
        ],
      ),
    );
  }
}
