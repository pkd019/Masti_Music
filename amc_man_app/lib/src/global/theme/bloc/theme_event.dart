part of 'theme_bloc.dart';

class ThemeEvent extends Equatable {
  const ThemeEvent({required this.appTheme});

  final AppTheme appTheme;

  @override
  List<Object> get props => [appTheme];
}
