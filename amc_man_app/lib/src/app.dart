import 'package:amc_man_app/src/authentication/bloc/authentication_bloc.dart';
import 'package:amc_man_app/src/constants.dart';
import 'package:amc_man_app/src/logger.dart';
import 'package:amc_man_app/src/route.dart';
import 'package:amc_man_app/src/ui/screens/home/home_screen.dart';
import 'package:amc_man_app/src/ui/screens/login/login_screen.dart';
import 'package:amc_man_app/src/ui/screens/map_asset/asset_map_page.dart';
import 'package:amc_man_app/src/ui/screens/splash/splash_screeen.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

import 'global/globals.dart' as global;
import 'global/theme/bloc/theme_bloc.dart';
import 'global/theme/theme.dart';

class DotApp extends StatelessWidget {
  const DotApp({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository,
          userRepository,
        ),
        child: BlocProvider(
          create: (context) => ThemeBloc(),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return AppView(
                context: context,
                state: state,
              );
            },
          ),
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key, required this.context, required this.state});

  final BuildContext context;
  final ThemeState state;
  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = global.navigatorKey;

  NavigatorState? get _navigator => _navigatorKey.currentState;

  Future<void> loadSavedTheme() async {
    final sharedpref = await SharedPreferences.getInstance();
    final themeIndex = sharedpref.getInt(kThemeKey) ?? 0;
    BlocProvider.of<ThemeBloc>(context).add(
      ThemeEvent(appTheme: AppTheme.values[themeIndex]),
    );
  }

  @override
  void initState() {
    loadSavedTheme().then((value) => logger.t('App Theme Loaded'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: widget.state.appThemeData,
      routes: {
        AssetMapPage.id: (BuildContext context) => const AssetMapPage(),
      },
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                global.user = state.user;
                _navigator!.pushAndRemoveUntil<void>(
                    newRoute(const HomeScreen()), (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator!.pushAndRemoveUntil(
                    newRoute(const LoginScreen()), (route) => false);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => newRoute(const SplashScreen()),
    );
  }
}
