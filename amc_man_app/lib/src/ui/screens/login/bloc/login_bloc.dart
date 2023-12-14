import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginInitial());

  final AuthenticationRepository _authenticationRepository;

  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is LoginButtonPressed) {
        yield LoginInProgress();

        if (kDebugMode) {
          print('-----------------------> ${event.email}');
        }

        await _authenticationRepository.logIn(
          email: event.email,
          password: event.password,
        );

        yield (LoginSuccess());
      }
    } on TimeoutException catch (e) {
      yield LoginFailure(message: e.message ?? 'Error: Timedout');
    } on FormatException catch (e) {
      yield LoginFailure(message: e.message);
    } catch (e) {
      yield LoginFailure(message: e.toString());
    }
  }
}
