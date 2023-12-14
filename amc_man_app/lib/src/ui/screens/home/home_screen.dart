import 'package:amc_man_app/src/ui/screens/help/help_page.dart';
import 'package:amc_man_app/src/ui/screens/settings/settings_page.dart';
import 'package:amc_man_app/src/ui/screens/summary/summary_page.dart';
import 'package:amc_man_app/src/ui/screens/view_assets/view_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

import '../../../route.dart';
import '../map_asset/category_page.dart';
import '../../components/app_drawer.dart';
import '../../components/bottom_nav_bar.dart';
import '../../components/home_grid_tile.dart';
import '../../../global/globals.dart' as global;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await global.assetHelper.loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            drawer: const AppDrawer(),
            bottomNavigationBar: AppBottomNavBar(
              bottomNavBarController: _pageController,
              currentIndex: state.pageIndex,
            ),
            body: PageView(
              controller: _pageController,
              onPageChanged: (i) {
                BlocProvider.of<HomeBloc>(context).add(HomeEvent(newIndex: i));
              },
              children: const [
                HomeMainWidget(),
                SettingsPage(showAppBar: false),
                HelpPage(showAppbar: false),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HomeMainWidget extends StatelessWidget {
  const HomeMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Spacer(flex: 4),
          HomeHeadingWidget(),
          Spacer(flex: 4),
          Expanded(flex: 50, child: HomeBody()),
        ],
      ),
    );
  }
}

class HomeHeadingWidget extends StatelessWidget {
  const HomeHeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AMC Man',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 44),
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
          Text(
            'Agartala Municipal Corporation',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 18,
                  letterSpacing: 2.0,
                ),
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .80,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: homeGridTiles.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return HomeGridTile(
          icon: homeGridTiles[index].icon,
          onPressed: homeGridTiles[index].onPressed,
          title: homeGridTiles[index].title,
        );
      },
    );
  }
}

final List<HomeGridContent> homeGridTiles = [
  HomeGridContent(
    title: 'Map Asset',
    icon: Icons.add_location_alt,
    onPressed: () {
      global.navigatorKey.currentState!.push(newRoute(const CategoryPage()));
    },
  ),
  // HomeGridContent(
  //   title: 'Send',
  //   icon: Icons.send,
  //   onPressed: () {
  //     global.navigatorKey.currentState.push(newRoute(SendPage()));
  //   },
  // ),
  HomeGridContent(
    title: 'Summary',
    icon: Icons.description,
    onPressed: () {
      global.navigatorKey.currentState!.push(newRoute(const SummaryPage()));
    },
  ),
  HomeGridContent(
    title: 'View Assets',
    icon: Icons.local_library,
    onPressed: () {
      global.navigatorKey.currentState!.push(newRoute(const ViewAssetsPage()));
    },
  ),
  // HomeGridContent(title: 'Helpline', icon: Icons.contact_support, onPressed: () {}),
  HomeGridContent(
    title: 'Help',
    icon: Icons.help,
    onPressed: () {
      global.navigatorKey.currentState!.push(newRoute(const HelpPage()));
    },
  ),
];
