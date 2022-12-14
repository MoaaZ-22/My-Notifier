// ignore_for_file: use_full_hex_values_for_flutter_colors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:my_task/shared/cubit/states.dart';
import 'package:my_task/shared/styles/colors.dart';
import '../../models/task.dart';
import '../components/components.dart';
import '../components/const.dart';
import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  var todayDateBeforeFormat = DateTime.now();

  var selectedDateForTime = DateTime.now();

  var dateBarStartDay = DateTime.now();

  var startAndEndTimeValidation = DateTime.now();

  TextEditingController? taskNameController = TextEditingController();
  TextEditingController? dateController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();
  TextEditingController? startTimeController = TextEditingController();
  TextEditingController? endTimeController = TextEditingController();

  List<String> dropDownButton = [
    'ar',
    'en',
  ];

  int selectIndex = 0;

  bool darkMode = false;

  String lang = 'en';

  void newTaskCatChangeIndex(int index) {
    selectIndex = index;
    emit(NewTaskItemChangeCategoryState());
  }

  String? createNewTaskValidation(value) {
    if (value!.isEmpty) {
      return '';
    }
    return null;
  }

  List<Task>? taskList = [];
  List<int>? keys = [];

  getBox() async {
    var box = await Hive.openBox<Task>('task');
    keys = [];
    keys = box.keys.cast<int>().toList();
    taskList = [];
    for (var key in keys!) {
      taskList?.add(box.get(key)!);
    }
    box.close();
    emit(GetBoxState());
  }

  addTask(Task task) async {
    await Hive.openBox<Task>('task').then((value) {
      value.add(task);
      emit(AddTaskSuccessState());
    }).catchError((error) {
      emit(AddTaskErrorState());
    }).then(
      (value) => getBox(),
    );
  }

  updateTask(Task task) async {
    await Hive.openBox<Task>('task').then((value) {
      final Map<dynamic, Task> taskMap = value.toMap();
      dynamic desiredKey;
      taskMap.forEach((key, value) {
        emit(UpdateTaskSuccessState());
        if (value.title == task.title) {
          desiredKey = key;
        }
      });
      return value.put(desiredKey, task);
    }).catchError((error) {
      emit(UpdateTaskErrorState());
    }).then(
      (value) => getBox(),
    );
  }

  deleteTask(Task task) async {
    await Hive.openBox<Task>('task').then((value) {
      final Map<dynamic, Task> taskMap = value.toMap();
      dynamic desiredKey;
      taskMap.forEach((key, value) {
        emit(DeleteTaskSuccessState());
        if (value.title == task.title) {
          desiredKey = key;
        }
      });
      return value.delete(desiredKey);
    }).catchError((error) {
      emit(DeleteTaskErrorState());
    }).then(
      (value) => getBox(),
    );
  }

  controllersClear() {
    taskNameController!.clear();
    dateController!.clear();
    descriptionController!.clear();
    startTimeController!.clear();
    endTimeController!.clear();
  }

  dateBarToggle(DateTime onDate) {
    todayDateBeforeFormat = onDate;
    emit(DateBarToggleState());
  }

  showDatePicked(context) {
    return showDatePicker(
            locale: lang == 'en' ? const Locale('en') : const Locale('ar'),
            context: context,
            initialDate: todayDateBeforeFormat,
            firstDate: DateTime.now(),
            lastDate: DateTime(2040, 12, 30))
        .then((value) {
      if (value != null) {
        FocusManager.instance.primaryFocus?.unfocus();
        emit(DatePickedSuccessState());
        var selectedDate = DateFormat('EEEE,   dd  MMMM', lang).format(value);
        dateController!.text = selectedDate;
        todayDateBeforeFormat = value;
      } else {
        value = todayDateBeforeFormat;
      }
    });
  }

  showTimePicked(context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      emit(TimePickedSuccessState());
      FocusManager.instance.primaryFocus?.unfocus();
      var day = AppCubit.get(context).todayDateBeforeFormat;
      AppCubit.get(context).selectedDateForTime = DateTime(
        day.year,
        day.month,
        day.day,
        value!.hour,
        value.minute,
      );
      AppCubit.get(context).startAndEndTimeValidation = DateTime(
        day.year,
        day.month,
        day.day,
        value.hour,
        value.minute,
      );
    }).catchError((error) {});
  }

  void buttonFunc({required GlobalKey<FormState> formKey, context}) {
    if (formKey.currentState!.validate()) {
      addTask(Task(
          title: taskNameController!.text,
          category: category!,
          date: todayDateBeforeFormat,
          startTime: selectedDateForTime,
          endTime: endTimeController!.text,
          description: descriptionController!.text));
      Navigator.pop(context);
      controllersClear();
      selectIndex = 0;
      selectedDateForTime = DateTime.now();
    } else if (taskNameController!.text.isEmpty ||
        descriptionController!.text.isEmpty) {
      snackBar(
          context: context,
          backgroundColor: Colors.red,
          barBehavior: SnackBarBehavior.floating,
          seconds: 3,
          text: 'Required, All Fields Are Required!');
    }
  }

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      darkMode = fromShared;
      emit(ChangeAppModeState());
    } else {
      darkMode = !darkMode;
    }
    CacheHelper.setDataIntoShPre(key: 'isDark', value: darkMode).then((value) {
      emit(ChangeAppModeState());
    });
  }

  changeColor({int? index}) {
    if (selectIndex == index) {
      if (darkMode == false) {
        return defaultColor;
      } else if (darkMode == true) {
        return darkThemeColor2!;
      }
    }
    if (selectIndex != index) {
      if (darkMode == false) {
        return Colors.white;
      } else if (darkMode == true) {
        return darkThemeColor1;
      }
    }
  }

  changeBorderColor({int? index}) {
    if (selectIndex == index) {
      if (darkMode == false) {
        return null;
      } else if (darkMode == true) {
        return null;
      }
    }
    if (selectIndex != index) {
      if (darkMode == false) {
        return Border.all(color: secondDefaultColor, width: 1);
      } else if (darkMode == true) {
        return Border.all(color: Colors.grey, width: 1);
      }
    }
  }

  void changeLanguage(String languageCode) {
    if (languageCode.isNotEmpty) {
      lang = languageCode;
    } else {
      lang = lang;
    }
    CacheHelper.saveData(key: 'Lang', value: lang).then((value) {
      emit(ChangeAppModeState());
    });
  }
}
