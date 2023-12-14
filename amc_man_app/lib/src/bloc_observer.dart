import 'package:amc_man_app/src/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlocObserver extends BlocObserver {
  void event(Bloc bloc, Object event) {
    logger.i(event);
    super.onEvent(bloc, event);
  }

  void errorEvent(Bloc bloc, Object error, StackTrace stackTrace) {
    logger.e(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    logger.i(transition);
    super.onTransition(bloc, transition);
  }
}
