part of 'assetcondition_bloc.dart';

class AssetconditionEvent extends Equatable {
  const AssetconditionEvent({required this.newValue});

  final String newValue;

  @override
  List<Object> get props => [newValue];
}
