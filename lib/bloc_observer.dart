import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_search/logger.dart';

class GlobalBlocObserver extends BlocObserver {
  /// {@macro counter_observer}
  const GlobalBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    logger.d('${bloc.runtimeType} $change');
  }
}
