part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupInProgress extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {
  const SignupFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
