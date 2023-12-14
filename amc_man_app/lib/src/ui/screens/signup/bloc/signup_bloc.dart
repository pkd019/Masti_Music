// ignore_for_file: override_on_non_overriding_member

import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(SignupInitial());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    try {
      if (event is SignupButtonPressed) {
        yield (SignupInProgress());

        await _authenticationRepository.signUp(
          name: event.name,
          email: event.email,
          password: event.password,
          phone: event.phone,
        );

        yield (SignupSuccess());
      }
    } on TimeoutException catch (e) {
      yield SignupFailure(message: e.message ?? 'Error: TimedOut');
    } on FormatException catch (e) {
      yield SignupFailure(message: e.message);
    } catch (e) {
      yield const SignupFailure(message: '');
    }
  }
}
