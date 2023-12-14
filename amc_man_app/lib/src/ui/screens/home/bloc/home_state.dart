part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({required this.pageIndex});

  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];
}
