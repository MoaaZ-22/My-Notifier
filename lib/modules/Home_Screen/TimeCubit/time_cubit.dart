import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(TimeInitial());

  static TimeCubit get(context) => BlocProvider.of(context);


  var streamTime = DateTime.now();
  void showUpdatedTime()
  {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      streamTime = DateTime.now();
      emit(HomeTimerState());
    });
  }
}
