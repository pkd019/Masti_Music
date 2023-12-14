import 'package:flutter/material.dart';

import '../../components/category_tiles.dart';
import '../../../global/globals.dart' as global;

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const CategoryBody(),
    );
  }
}

class CategoryBody extends StatefulWidget {
  const CategoryBody({super.key});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  late List<Padding> _categoryList;

  @override
  void initState() {
    _categoryList = global.assetHelper.getClasses
        .map(
          (e) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClassTile(classType: e as String),
          ),
        )
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Select the Category\nof the Asset',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 40.0),
                overflow: TextOverflow.fade,
                softWrap: true,
                textAlign: TextAlign.left,
                semanticsLabel: 'select category',
              ),
            ],
          ),
          const Spacer(),
          Expanded(
            flex: 20,
            child: Scrollbar(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _categoryList.length,
                itemBuilder: (context, index) => _categoryList[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
