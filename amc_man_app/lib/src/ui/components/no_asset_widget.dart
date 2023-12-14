import 'package:flutter/material.dart';

class NoAssetWidget extends StatelessWidget {
  const NoAssetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No Asset Found',
        style:
            Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 16),
      ),
    );
  }
}
