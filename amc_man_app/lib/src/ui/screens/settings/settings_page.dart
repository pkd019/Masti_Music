import 'package:amc_man_app/src/route.dart';
import 'package:amc_man_app/src/ui/components/change_password.dart';
import 'package:amc_man_app/src/ui/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/theme/bloc/theme_bloc.dart';
import '../../../global/theme/theme.dart';
import '../../components/custom_tile.dart';
import '../../../extensions/snack_bar.dart';
import '../../../global/globals.dart' as global;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, this.showAppBar = true});
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar() : null,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            _SettingsHeader(),
            const Spacer(),
            const Expanded(flex: 25, child: SettingsBody()),
          ],
        ),
      ),
    );
  }
}

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  late bool isDarkTheme;

  @override
  void didChangeDependencies() {
    isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTile(
          title: 'My Profile',
          leadingIcon: Icons.person,
          onTap: () {
            global.navigatorKey.currentState!
                .push(newRoute(const ProfilePage()));
          },
          trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
          subTitle: '',
        ),
        CustomTile(
          title: 'Change Password',
          leadingIcon: Icons.lock,
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => const ChangePasswordDialog());
          },
          trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
          subTitle: '',
        ),
        CustomTile(
          title: 'Dark Theme',
          leadingIcon: Icons.brightness_2,
          trailing: Switch(
            value: isDarkTheme,
            onChanged: (newVal) {
              setState(() {
                isDarkTheme = newVal;
              });
              BlocProvider.of<ThemeBloc>(context).add(
                ThemeEvent(
                    appTheme: isDarkTheme ? AppTheme.dark : AppTheme.light),
              );
            },
          ),
          subTitle: '',
          onTap: () {},
        ),
        const Divider(),
        CustomTile(
          title: 'Terms and Privacy Policy',
          leadingIcon: Icons.policy,
          onTap: () {
            context.showSnackbar('Terms and Privacy Policy: Under Development');
          },
          trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
          subTitle: '',
        ),
        CustomTile(
          title: 'App Info',
          leadingIcon: Icons.info,
          onTap: () {
            showAboutDialog(
              context: context,
              applicationIcon: Image.asset(
                'assets/logo.png',
                height: 50,
              ),
              applicationName: 'AMC Man',
              applicationVersion: 'v1.0.0',
            );
          },
          subTitle: '',
          trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
        ),
      ],
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Settings',
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
