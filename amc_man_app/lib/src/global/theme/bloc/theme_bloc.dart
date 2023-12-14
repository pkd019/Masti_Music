import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';
import '../../../constants.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(appThemeData: lightTheme));

  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setInt(kThemeKey, event.appTheme.index);

    yield ThemeState(appThemeData: appThemeData[event.appTheme] ?? lightTheme);
  }
}
