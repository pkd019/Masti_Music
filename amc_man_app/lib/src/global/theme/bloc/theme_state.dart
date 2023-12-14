part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.appThemeData});

  final ThemeData appThemeData;
  @override
  List<Object> get props => [appThemeData];
}
