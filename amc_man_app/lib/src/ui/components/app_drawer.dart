import 'package:amc_man_app/src/authentication/bloc/authentication_bloc.dart';
import 'package:amc_man_app/src/route.dart';
import 'package:amc_man_app/src/ui/screens/help/help_page.dart';
import 'package:amc_man_app/src/ui/screens/home/home_screen.dart';
import 'package:amc_man_app/src/ui/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/globals.dart' as global;

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      semanticLabel: 'drawer menu',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: DrawerHeader()),
          Expanded(flex: 3, child: DrawerBody()),
        ],
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 5,
              child: Image.asset(
                'assets/logo.png',
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AMC Man',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      'Agartala Municipal Corporation',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DrawerTileContent> drawerContentList = [
      DrawerTileContent(
        label: 'Home',
        icon: Icons.home,
        onPressed: () {
          global.navigatorKey.currentState!.push(newRoute(HomeScreen()));
        },
      ),
      DrawerTileContent(
        label: 'Settings',
        icon: Icons.settings,
        onPressed: () {
          global.navigatorKey.currentState!
              .push(newRoute(const SettingsPage()));
        },
      ),
      DrawerTileContent(
        label: 'Contact Us',
        icon: Icons.contact_mail,
        onPressed: () {
          global.navigatorKey.currentState!.push(newRoute(const HelpPage()));
        },
      ),
      DrawerTileContent(
          label: 'Logout',
          icon: Icons.logout,
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationLogoutRequested());
          }),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: drawerContentList
            .map(
              (e) => DrawerTile(
                  label: e.label, icon: e.icon, onPressed: e.onPressed),
            )
            .toList(),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onPressed,
    );
  }
}

class DrawerTileContent {
  const DrawerTileContent({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final void Function() onPressed;
}
