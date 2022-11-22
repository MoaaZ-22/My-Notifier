import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(TimeInitial());

  static TimeCubit get(context) => BlocProvider.of(context);

  var dateNow = DateTime.now();
  var streamTime = DateFormat('hh:mm a').format(DateTime.now());

  void showUpdatedTime()
  {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      streamTime = DateFormat('hh:mm a').format(DateTime.now());
      dateNow = DateTime.now();
      emit(HomeTimerState());
    });
  }
}
