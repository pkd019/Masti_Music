part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent({required this.newIndex});

  final int newIndex;

  @override
  List<Object> get props => [newIndex];
}
