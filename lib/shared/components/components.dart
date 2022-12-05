// ignore_for_file: avoid_print, unnecessary_null_in_if_null_operators

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:my_task/models/task.dart';
import 'package:my_task/modules/Home_Screen/TimeCubit/time_cubit.dart';
import 'package:my_task/shared/components/app_localization.dart';
import 'package:my_task/shared/components/const.dart';
import 'package:sizer/sizer.dart';
import '../../modules/Home_Screen/task_item.dart';
import '../../modules/New_Task_Screen/new_task.dart';
import '../cubit/cubit.dart';
import '../network/local/notification_helper.dart';
import '../styles/colors.dart';
import '../styles/iconly.dart';

void navigateTo(context, dynamic widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

Widget circularProIndicator({required double? height, required double? width}) =>
    Center(
      child: SizedBox(
        height: height,
        width: width,
        child: const CircularProgressIndicator(
          color: Color(0xff7BB3FF),
          strokeWidth: 4,
        ),
      ),
    );

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar({context, required Color? backgroundColor, required SnackBarBehavior? barBehavior, required int? seconds, required String? text,}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      elevation: 5,
      behavior: barBehavior,
      duration: Duration(seconds: seconds!),
      content: Text(
        text!,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14, fontFamily: 'SegoeUIBold'),
      )));
}

class RPSCustomPainter extends CustomPainter {
  final Color color;

  RPSCustomPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    Path path0 = Path();
    canvas.drawShadow(path0, Colors.grey, 10, false);
    path0.moveTo(size.width, 0);
    path0.quadraticBezierTo(
        size.width * 0.4373594, 0, size.width * 0.2498125, 0);
    path0.quadraticBezierTo(size.width * 0.4609250, size.height * 0.0670400,
        size.width * 0.4534375, size.height * 0.3590000);
    path0.quadraticBezierTo(size.width * 0.4421125, size.height * 0.6097600,
        size.width * 0.5625000, size.height * 0.7000000);
    path0.cubicTo(
        size.width * 0.6223500,
        size.height * 0.7419800,
        size.width * 0.7016875,
        size.height * 0.7467800,
        size.width * 0.7485625,
        size.height * 0.7405000);
    path0.cubicTo(
        size.width * 0.8933125,
        size.height * 0.7201400,
        size.width * 0.9372625,
        size.height * 0.8174800,
        size.width * 0.9518250,
        size.height * 0.8394600);
    path0.cubicTo(
        size.width * 0.9828375,
        size.height * 0.8935200,
        size.width * 1.0039625,
        size.height * 0.9705600,
        size.width,
        size.height);
    path0.quadraticBezierTo(
        size.width * 1.0003875, size.height * 0.9766800, size.width, 0);
    path0.close();
    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Widget backgroundWidget({context}) {
  return Row(
    children: [
      Container(
        color: AppCubit.get(context).darkMode == false
            ? Colors.blue
            : darkThemeColor2,
        height: double.infinity,
        width: MediaQuery.of(context).size.width * 0.5,
      ),
      Container(
        color: AppCubit.get(context).darkMode == false
            ? Colors.white
            : darkThemeColor1,
        height: double.infinity,
        width: MediaQuery.of(context).size.width * 0.5,
      )
    ],
  );
}

Widget dateBar(DateTime now, context) {
  var appCubit = AppCubit.get(context);
  return DatePicker(
    padding: EdgeInsets.all(appCubit.lang == 'en' ? 3.0 : 0),
    locale: appCubit.lang,
    appCubit.dateBarStartDay,
    height: 11.2.h,
    width: 19.w,
    border: Border.all(
        color: AppCubit.get(context).darkMode == false
            ? Colors.blue
            : Colors.grey.shade800,
        width: 2),
    initialSelectedDate: appCubit.todayDateBeforeFormat,
    selectionColor:
        appCubit.darkMode == false ? defaultColor : darkThemeColor2!,
    deactivatedColor: Colors.red,
    selectedTextColor: Colors.white,
    dateTextStyle: TextStyle(
        fontSize: 16.8.sp,
        fontFamily: 'AsapCondensed-Bold',
        color: AppCubit.get(context).darkMode == false
            ? Colors.black
            : Colors.grey),
    dayTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: AppCubit.get(context).darkMode == false
            ? Colors.black
            : Colors.grey),
    monthTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: AppCubit.get(context).darkMode == false
            ? Colors.black
            : Colors.grey),
    onDateChange: (onDate) {
      now = onDate;
      AppCubit.get(context).dateBarToggle(onDate);
    },
  );
}

PreferredSizeWidget? newTaskAppBar({void Function()? leadingFunc, void Function()? actionsFunc, context}) {
  var appCubit = AppCubit.get(context);
  return AppBar(
    titleSpacing: 0,
    elevation: 0,
    leadingWidth: 0,
    backgroundColor: AppCubit.get(context).darkMode == false
        ? Colors.white
        : darkThemeColor1,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Row(
        children: [
          IconButton(
              splashRadius: 25,
              iconSize: 25,
              onPressed: leadingFunc,
              icon: Icon(
                appCubit.lang == 'en'
                    ? IconlyBroken.chevron_left
                    : IconlyBroken.arrow_right_2,
                color: AppCubit.get(context).darkMode == false
                    ? Colors.black
                    : Colors.grey,
                size: 28,
              )),
        ],
      ),
    ),
  );
}

PreferredSizeWidget? historyAppBar(
    {context, void Function()? leadingFunc, void Function()? actionsFunc}) {
  return AppBar(
    titleSpacing: 0,
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppCubit.get(context).darkMode == false
        ? Colors.white
        : darkThemeColor1,
    automaticallyImplyLeading: false,
    title: Text(
      'history'.tr(context),
      style: TextStyle(
          color: AppCubit.get(context).darkMode == false
              ? Colors.black
              : Colors.white,
          fontSize: 22,
          fontFamily: 'AsapCondensed-Bold',
          letterSpacing: 1.5),
    ),
    leading: IconButton(
        splashRadius: 25,
        iconSize: 28,
        onPressed: leadingFunc,
        icon: Icon(
          AppCubit.get(context).lang == 'en'
              ? IconlyBroken.chevron_left
              : IconlyBroken.arrow_right_2,
          color: AppCubit.get(context).darkMode == false
              ? Colors.black
              : Colors.grey,
          size: 28,
        )),
  );
}

Widget defaultTextFormFiled(
    {context,
    String? title,
    String? hint,
    TextEditingController? controller,
    Widget? widget,
    Widget? suffixWidget,
    bool? readOnly,
    String? Function(String?)? validator,
    TextInputType? keyboardType}) {
  return Container(
    padding: EdgeInsets.only(top: 20, right: 3.3.w, left: 7.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: secondDefaultColor, fontSize: 18),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                cursorColor: AppCubit.get(context).darkMode == false
                    ? Colors.black
                    : Colors.blue,
                keyboardType: keyboardType,
                readOnly: readOnly ?? false,
                validator: validator,
                style: TextStyle(
                    height: 1,
                    color: AppCubit.get(context).darkMode == false
                        ? Colors.black
                        : Colors.white,
                    fontSize: 20,
                    fontFamily: 'AsapCondensed-Bold'),
                decoration: InputDecoration(
                    suffix: suffixWidget ?? const SizedBox(),
                    hintText: hint,
                    errorStyle: const TextStyle(
                        fontSize: 0, height: 0, color: Colors.transparent),
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 16),
                    contentPadding: EdgeInsets.zero,
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: secondDefaultColor, width: 2)),
                    errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: secondDefaultColor, width: 2)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: secondDefaultColor, width: 2))),
              ),
            ),
            widget == null
                ? const SizedBox()
                : SizedBox(
                    width: 10.w,
                  ),
            widget ?? const SizedBox()
          ],
        ),
      ],
    ),
  );
}

Widget newTaskCatList(context) {
  List<String> newTaskCategories = [
    'development'.tr(context),
    'research'.tr(context),
    'design'.tr(context),
    'backend'.tr(context),
    'meeting'.tr(context)
  ];
  return SizedBox(
    height: 4.5.h,
    child: NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: ListView.builder(
          padding: EdgeInsets.only(left: 5.w, right: 1.w),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () {
                    AppCubit.get(context).newTaskCatChangeIndex(index);
                    category = newTaskCategories[index];
                    print(category);
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    padding: const EdgeInsets.all(8),
                    height: 4.h,
                    decoration: BoxDecoration(
                        color: AppCubit.get(context).changeColor(index: index),
                        borderRadius: BorderRadius.circular(6),
                        border: AppCubit.get(context)
                            .changeBorderColor(index: index)),
                    child: Text(
                      newTaskCategories[index],
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          height: 1.2,
                          fontSize: 12,
                          color: AppCubit.get(context).selectIndex == index
                              ? Colors.white
                              : AppCubit.get(context).darkMode == true
                                  ? Colors.grey
                                  : secondDefaultColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
          itemCount: newTaskCategories.length),
    ),
  );
}

class ReusableTextButton extends StatelessWidget {
  final String? buttonText;
  final void Function()? onPressed;
  final Color color;
  final Color textColor;
  final double radius;
  final double horizontal;
  final double? fontSize;
  final double? height;
  final BorderSide? borderSide;

  const ReusableTextButton(
      {Key? key,
      this.buttonText,
      this.onPressed,
      required this.color,
      required this.textColor,
      this.borderSide,
      this.radius = 8,
      this.horizontal = 0,
      required this.fontSize,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      height: height,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius), // <-- Radius
              ),
              backgroundColor: color,
              side: borderSide ?? null,
              alignment: AlignmentDirectional.center),
          onPressed: onPressed,
          child: Text(
            buttonText!,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: fontSize,
                fontFamily: 'Oswald-Bold',
                color: textColor),
          )),
    );
  }
}

showTimePicked(context) {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  ).then((value) {
    print(value);
    var day = AppCubit.get(context).todayDateBeforeFormat;
    AppCubit.get(context).selectedDateForTime = DateTime(day.year, day.month, day.day, value!.hour, value.minute,);
    AppCubit.get(context).startAndEndTimeValidation = DateTime(
      day.year,
      day.month,
      day.day,
      value.hour,
      value.minute,
    );
  }).catchError((error) {
    print(error.toString());
  });
}

showEndTimePicker({context}) {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  ).then((value) {
    var day = AppCubit.get(context).todayDateBeforeFormat;
    // print(value);
    // print(value);
    if (DateTime(
      day.year,
      day.month,
      day.day,
      value!.hour,
      value.minute,
    ).isAfter(AppCubit.get(context).startAndEndTimeValidation)) {
      AppCubit.get(context).endTimeController!.text =
          DateFormat('hh:mm a', AppCubit.get(context).lang).format(
              DateTime(day.year, day.month, day.day, value.hour, value.minute));
    } else {
      print('Error');
      AppCubit.get(context).endTimeController!.text =
          DateFormat('hh:mm a', AppCubit.get(context).lang).format(
              AppCubit.get(context)
                  .startAndEndTimeValidation
                  .add(const Duration(hours: 1)));
      snackBar(
          context: context,
          backgroundColor: Colors.red,
          barBehavior: SnackBarBehavior.floating,
          seconds: 3,
          text: 'The end time should be after the start time');
    }
  });
}

Widget emptyWidget() {
  return Container(
    margin: EdgeInsets.all(6.h),
    child: SvgPicture.asset('assets/images/add_files.svg'),
  );
}

class UpdatedTime extends StatelessWidget {
  const UpdatedTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimeCubit, TimeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var translatedDate = DateFormat('hh:mm a', AppCubit.get(context).lang)
            .format(TimeCubit.get(context).streamTime);
        return Text(translatedDate,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontSize: 18.sp, color: Colors.white));
      },
    );
  }
}

class ReusableDrawerButton extends StatelessWidget {
  final String text;
  final IconData prefixIcon;
  final void Function()? onPressed;

  const ReusableDrawerButton(
      {Key? key, required this.text, required this.prefixIcon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 50,
      padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
                fontSize: 18,
                fontFamily: 'AsapCondensed-Bold',
                color: Colors.white),
          ),
          const Spacer(),
          Icon(
            prefixIcon,
            size: 25,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

showModelSheet({context, required Task task}) {
  return showModalBottomSheet(
      elevation: 5,
      isDismissible: true,
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 30.h,
          padding: const EdgeInsets.all(4),
          color: AppCubit.get(context).darkMode == false
              ? Colors.white
              : darkThemeColor1,
          child: Column(
            children: [
              Container(
                width: 40.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
              ),
              SizedBox(
                height: 4.h,
              ),
              ReusableTextButton(
                height: 6.8.h,
                color: Colors.red,
                textColor: Colors.white,
                buttonText: 'delete'.tr(context),
                onPressed: () {
                  AppCubit.get(context).deleteTask(task);
                  Navigator.pop(context);
                },
                horizontal: 9.w,
                radius: 100,
                fontSize: 20.sp,
              ),
              SizedBox(
                height: 2.h,
              ),
              ReusableTextButton(
                height: 6.8.h,
                borderSide: const BorderSide(color: Colors.grey, width: 1),
                color: AppCubit.get(context).darkMode == false
                    ? Colors.grey[300]!
                    : Colors.grey[600]!,
                textColor: AppCubit.get(context).darkMode == false
                    ? Colors.black
                    : Colors.white,
                buttonText: 'cancel'.tr(context),
                onPressed: () {
                  Navigator.pop(context);
                },
                horizontal: 8.w,
                radius: 100,
                fontSize: 20.sp,
              ),
              SizedBox(
                height: 1.h,
              ),
            ],
          ),
        );
      });
}

Widget categoriesIcon({String? category}) {
  if (category == 'Development' || category == 'تطوير') {
    return Padding(
      padding: EdgeInsets.only(right: 2.5.w),
      child: Icon(
        IconlyBroken.code_solid,
        color: defaultCategoryColor,
        size: defaultSize,
      ),
    );
  } else if (category == 'Research' || category == 'بحث') {
    return Icon(
      Icons.search,
      color: defaultCategoryColor,
      size: defaultSize,
    );
  } else if (category == 'Design' || category == 'تصميم') {
    return Icon(
      IconlyBroken.palette_solid,
      color: defaultCategoryColor,
      size: defaultSize,
    );
  } else if (category == 'Backend' || category == 'باك اند') {
    return Icon(
      IconlyBroken.server_solid,
      color: defaultCategoryColor,
      size: defaultSize,
    );
  } else if (category == 'Meeting' || category == 'لقاء') {
    return Icon(
      IconlyBroken.date,
      color: defaultCategoryColor,
      size: defaultSize,
    );
  } else {
    return Padding(
      padding: EdgeInsets.only(right: 2.5.w),
      child: Icon(
        IconlyBroken.meeting,
        color: defaultCategoryColor,
        size: defaultSize,
      ),
    );
  }
}

Widget newTaskBuildScreen({context}) {
  var appCubit = AppCubit.get(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      appCubit.lang == 'en'
          ? SizedBox(
              height: 2.h,
            )
          : const SizedBox(),
      Container(
        padding: EdgeInsets.only(right: 3.3.w, left: 7.w),
        child: Row(
          children: [
            Text(
              'createNewTask'.tr(context),
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 28),
            ),
            const Spacer(),
            Icon(
              IconlyBroken.clipboard,
              color: secondDefaultColor,
              size: 40,
            ),
          ],
        ),
      ),
      defaultTextFormFiled(
          keyboardType: TextInputType.name,
          context: context,
          title: 'taskName'.tr(context),
          controller: appCubit.taskNameController,
          hint: 'taskTitle'.tr(context),
          readOnly: false,
          validator: (value) => appCubit.createNewTaskValidation(value)),
      appCubit.lang == 'en'
          ? SizedBox(
        height: 4.h,
      )
          : SizedBox(height: 2.h,),
      Padding(
        padding: EdgeInsets.only(left: 7.w, right: 3.3.w),
        child: Text(
          'category'.tr(context),
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: secondDefaultColor, fontSize: 18),
        ),
      ),
      appCubit.lang == 'en'
          ? SizedBox(
              height: 2.h,
            )
          : const SizedBox(),
      newTaskCatList(context),
      defaultTextFormFiled(
        keyboardType: TextInputType.datetime,
        context: context,
        title: 'date'.tr(context),
        controller: appCubit.dateController,
        readOnly: true,
        widget: InkWell(
          onTap: () {
            appCubit.showDatePicked(context);
          },
          borderRadius: BorderRadius.circular(25),
          child: CircleAvatar(
            radius: 3.5.h,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.date_range,
              color: Colors.white,
              size: 5.h,
            ),
          ),
        ),
      ),
      appCubit.lang == 'en'
          ? SizedBox(
              height: 2.h,
            )
          : SizedBox(
              height: 1.h,
            ),
      Row(
        children: [
          Expanded(
            child: defaultTextFormFiled(
                keyboardType: TextInputType.none,
                title: 'startTime'.tr(context),
                context: context,
                readOnly: true,
                suffixWidget: IconButton(
                  padding: EdgeInsets.zero,
                  splashRadius: 24,
                  onPressed: () {
                    appCubit.showTimePicked(context);
                  },
                  icon: Icon(
                    Icons.watch_later_outlined,
                    color: Colors.blue,
                    size: 3.5.h,
                  ),
                ),
                controller: appCubit.startTimeController),
          ),
          Expanded(
            child: defaultTextFormFiled(
                keyboardType: TextInputType.none,
                title: 'endTime'.tr(context),
                context: context,
                readOnly: true,
                suffixWidget: IconButton(
                  splashRadius: 24,
                  onPressed: () {
                    showEndTimePicker(context: context);
                  },
                  icon: Icon(
                    Icons.watch_later_outlined,
                    color: Colors.blue,
                    size: 3.5.h,
                  ),
                ),
                controller: appCubit.endTimeController),
          ),
        ],
      ),
      SizedBox(
        height: 2.h,
      ),
      defaultTextFormFiled(
          keyboardType: TextInputType.name,
          title: 'description'.tr(context),
          context: context,
          hint: 'writeDescription'.tr(context),
          controller: appCubit.descriptionController,
          validator: (value) => appCubit.createNewTaskValidation(value)),
    ],
  );
}

Widget homeBottomWidget(context) {
  var taskList = AppCubit.get(context).taskList;
  var notifyHelper = NotifyHelper();
  var appCubit = AppCubit.get(context);
  return Align(
    alignment: AlignmentDirectional.bottomCenter,
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
          color: appCubit.darkMode == false ? Colors.blue : darkThemeColor2,
          borderRadius: appCubit.lang == 'en'
              ? const BorderRadius.only(topRight: Radius.circular(35))
              : const BorderRadius.only(topLeft: Radius.circular(35))),
      child: ConditionalBuilder(
        condition: taskList!.isNotEmpty,
        builder: (context) => Scrollbar(
          scrollbarOrientation: ScrollbarOrientation.left,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding:
                  EdgeInsets.only(left: 5.h, top: 5.h, right: 4.h, bottom: 5.h),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var task = AppCubit.get(context).taskList![index];
                var key = AppCubit.get(context).keys![index];

                // 10 min Before task start time
                notifyHelper.scheduledNotification(
                    id: key,
                    hour: task.startTime.hour,
                    minutes: task.startTime.minute,
                    task: task);

                if (DateFormat('EEEE, dd MMMM', appCubit.lang)
                        .format(task.date) ==
                    DateFormat('EEEE, dd MMMM', appCubit.lang)
                        .format(AppCubit.get(context).todayDateBeforeFormat)) {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: TaskItem(
                            border: appCubit.darkMode == true ? Border.all(color: Colors.blueGrey, width: 1) : null,
                            taskId: appCubit.keys![index],
                            model: taskList[index],
                            width: 30.w,
                            fontSize: 15.3.sp,
                          ),
                        ),
                      ));
                } else {
                  return Container();
                }
              },
              itemCount: AppCubit.get(context).taskList!.length),
        ),
        fallback: (context) => emptyWidget(),
      ),
    ),
  );
}

Widget homeTopWidget(context) {
  var appCubit = AppCubit.get(context);
  String? date =
      DateFormat('EEEE, dd MMMM', appCubit.lang).format(DateTime.now());
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.45,
    padding: EdgeInsets.only(top: 3.h),
    decoration: BoxDecoration(
        color: AppCubit.get(context).darkMode == false
            ? Colors.white
            : darkThemeColor1,
        borderRadius: appCubit.lang == 'en'
            ? const BorderRadius.only(bottomLeft: Radius.circular(35))
            : const BorderRadius.only(bottomRight: Radius.circular(35))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MaterialButton(
          height: 6.h,
          minWidth: 0,
          padding: const EdgeInsets.all(3),
          shape: const CircleBorder(),
          onPressed: () {
            ZoomDrawer.of(context)?.toggle();
          },
          child: Icon(Icons.menu_rounded,
              color: appCubit.darkMode == false ? Colors.black : Colors.grey,
              size: 30),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6.8.h, left: 4.w, right: 3.w),
          child: Row(
            children: [
              Text(
                'myNotifier'.tr(context),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const Spacer(),
              MaterialButton(
                minWidth: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(12),
                color: Colors.blue,
                onPressed: () {
                  navigateTo(context, const NewTaskScreen());
                  appCubit.selectedDateForTime = DateTime.now();
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.03,
              left: 4.w,
              right: 3.w),
          child: Row(
            children: [
              Text(
                'today'.tr(context),
                style: TextStyle(
                    fontFamily: 'AsapCondensed-Medium',
                    fontSize: 20,
                    color: appCubit.darkMode == false
                        ? Colors.black
                        : Colors.grey),
              ),
              const Spacer(),
              Text(
                date,
                style: Theme.of(context).textTheme.caption?.copyWith(
                    fontFamily: 'Oswald-Regular',
                    color: appCubit.darkMode == false
                        ? Colors.black
                        : Colors.grey),
              )
            ],
          ),
        ),
        SizedBox(height: 1.5.h,),
        dateBar(DateTime.now(), context),

      ],
    ),
  );
}
