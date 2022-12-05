// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_task/shared/components/app_localization.dart';
import 'package:my_task/shared/cubit/cubit.dart';
import 'package:sizer/sizer.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode (SystemUiMode.immersive, overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    final formKey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var appCubit = AppCubit.get(context);
        AppCubit.get(context).startTimeController!.text = DateFormat('hh:mm a',appCubit.lang).format(appCubit.selectedDateForTime);
        AppCubit.get(context).endTimeController!.text =  DateFormat('hh:mm a', appCubit.lang).format(appCubit.selectedDateForTime.add(const Duration(hours: 1)));
        appCubit.dateController!.text = DateFormat('EEEE, dd MMMM', appCubit.lang).format(appCubit.todayDateBeforeFormat);
        return GestureDetector(
          onTap: ()
          {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SafeArea(
            child: Scaffold(
              appBar: newTaskAppBar(context: context, leadingFunc: () {Navigator.pop(context);appCubit.controllersClear();appCubit.selectIndex = 0;}, actionsFunc: () {}),
              backgroundColor: AppCubit.get(context).darkMode ==  false ? Colors.white : darkThemeColor1,
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 4.h),
                child: ReusableTextButton(
                  height: 8.8.h,
                  fontSize: 28.sp,
                  color: Colors.blue,
                  textColor: Colors.white,
                  buttonText: 'createTask'.tr(context),
                  onPressed: ()
                  {
                    appCubit.buttonFunc(formKey: formKey, context: context);
                  },
                ),
              ),
              extendBody: false,
              body: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 3.h, right: 2.w),
                scrollDirection: Axis.vertical,
                child: Form(
                  key: formKey,
                  child: newTaskBuildScreen(context: context),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
