part of 'assetcondition_bloc.dart';

class AssetconditionState extends Equatable {
  const AssetconditionState({required this.newValue});

  final String newValue;

  @override
  List<Object> get props => [newValue];
}
