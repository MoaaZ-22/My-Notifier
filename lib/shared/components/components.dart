// ignore_for_file: avoid_print, unnecessary_null_in_if_null_operators

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_task/models/task.dart';
import 'package:my_task/modules/Home_Screen/TimeCubit/time_cubit.dart';
import 'package:my_task/shared/components/const.dart';
import 'package:sizer/sizer.dart';
import '../cubit/cubit.dart';
import '../styles/colors.dart';
import '../styles/iconly.dart';

void navigateTo(context, dynamic widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

Widget circularProIndicator({required double? height, required double? width}) =>  Center(
  child: SizedBox(
    height: height,
    width: width,
    child: const CircularProgressIndicator(
      color: Color(0xff7BB3FF),
      strokeWidth: 4,
    ),
  ),
);

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar({context, required Color? backgroundColor, required SnackBarBehavior? barBehavior, required int? seconds, required String? text,})
{
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: backgroundColor,
          elevation: 5,
          behavior: barBehavior,
           duration: Duration(seconds: seconds!),
    content: Text(text!,
    textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 14,fontFamily: 'SegoeUIBold'),)));
}

class RPSCustomPainter extends CustomPainter{
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
    path0.moveTo(size.width,0);
    path0.quadraticBezierTo(size.width*0.4373594,0,size.width*0.2498125,0);
    path0.quadraticBezierTo(size.width*0.4609250,size.height*0.0670400,size.width*0.4534375,size.height*0.3590000);
    path0.quadraticBezierTo(size.width*0.4421125,size.height*0.6097600,size.width*0.5625000,size.height*0.7000000);
    path0.cubicTo(size.width*0.6223500,size.height*0.7419800,size.width*0.7016875,size.height*0.7467800,size.width*0.7485625,size.height*0.7405000);
    path0.cubicTo(size.width*0.8933125,size.height*0.7201400,size.width*0.9372625,size.height*0.8174800,size.width*0.9518250,size.height*0.8394600);
    path0.cubicTo(size.width*0.9828375,size.height*0.8935200,size.width*1.0039625,size.height*0.9705600,size.width,size.height);
    path0.quadraticBezierTo(size.width*1.0003875,size.height*0.9766800,size.width,0);
    path0.close();
    canvas.drawPath(path0, paint0);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

Widget backgroundWidget({context})
{
  return Row(
    children: [
      Container(
        color: AppCubit.get(context).darkMode == false? Colors.blue : darkThemeColor2,
        height: double.infinity,width: MediaQuery.of(context).size.width*0.5,),
      Container(
        color: AppCubit.get(context).darkMode == false? Colors.white : darkThemeColor1,
        height: double.infinity,width: MediaQuery.of(context).size.width*0.5,)
    ],);
}


Widget dateBar(DateTime now, context)
{
  var appCubit = AppCubit.get(context);
  return DatePicker(
    DateTime.now(),
    height: 10.7.h,
    width: 18.w,
    border:  Border.all(color: AppCubit.get(context).darkMode ==  false ? Colors.blue : Colors.grey.shade800,width: 2),
    initialSelectedDate: appCubit.todayDateBeforeFormat,
    selectionColor: appCubit.darkMode ==  false ? defaultColor : darkThemeColor2!,
    deactivatedColor: Colors.red,
    selectedTextColor: Colors.white,
    dateTextStyle: TextStyle(fontSize: 20, fontFamily: 'AsapCondensed-Bold', color: AppCubit.get(context).darkMode ==  false ? Colors.black : Colors.grey),
    dayTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppCubit.get(context).darkMode ==  false ? Colors.black : Colors.grey),
    monthTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppCubit.get(context).darkMode ==  false ? Colors.black : Colors.grey),
    onDateChange: (onDate)
    {
      now = onDate;
      AppCubit.get(context).dateBarToggle(onDate);
      print(now);
    },
  );
}

PreferredSizeWidget? newTaskAppBar({void Function()? leadingFunc, void Function()? actionsFunc, context})
{
  return AppBar(
    titleSpacing: 0,
    elevation: 0,
    leadingWidth: 0,
    backgroundColor: AppCubit.get(context).darkMode ==  false ? Colors.white : darkThemeColor1,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        children: [
          IconButton(
              splashRadius: 25,
              iconSize: 28,
              onPressed: leadingFunc, icon: Icon(IconlyBroken.chevron_left,
            color: AppCubit.get(context).darkMode ==  false ? Colors.black : Colors.grey,
            size: 28,)),
          const Spacer(),
          IconButton(
              splashRadius: 25,
              iconSize: 30,
              onPressed: actionsFunc, icon: Icon(Icons.menu_rounded,
            color: AppCubit.get(context).darkMode ==  false ? Colors.black : Colors.grey,))
        ],
      ),
    ),
  );
}

PreferredSizeWidget? historyAppBar({context ,void Function()? leadingFunc, void Function()? actionsFunc})
{
  return AppBar(
    titleSpacing: 0,
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppCubit.get(context).darkMode == false ? Colors.white : darkThemeColor1,
    automaticallyImplyLeading: false,
    title: Text('History', style: TextStyle(
        color: AppCubit.get(context).darkMode == false ? Colors.black : Colors.white,
        fontSize: 22, fontFamily: 'AsapCondensed-Bold', letterSpacing: 1.5),),
    leading: IconButton(
        splashRadius: 25,
        iconSize: 28,
        onPressed: leadingFunc, icon: Icon(IconlyBroken.chevron_left,
      color: AppCubit.get(context).darkMode ==  false ? Colors.black : Colors.grey,
      size: 28,)),
  );
}

Widget defaultTextFormFiled({context, String? title, String? hint, TextEditingController? controller, Widget? widget, Widget? suffixWidget, bool? readOnly, String? Function(String?)? validator, TextInputType? keyboardType})
{
  return Container(
    padding: EdgeInsets.only(top: 20,right: 3.3.w,left: 7.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!, style: Theme.of(context).textTheme.headline6?.copyWith(color: secondDefaultColor, fontSize: 18),),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                cursorColor: AppCubit.get(context).darkMode ==  false ? Colors.black : Colors.blue,
                keyboardType: keyboardType,
                readOnly: readOnly ?? false,
                validator: validator,
                style: TextStyle(
                    height: 1,
                    color:  AppCubit.get(context).darkMode ==  false ? Colors.black : Colors.white,
                    fontSize: 20,fontFamily: 'AsapCondensed-Bold'),
                decoration: InputDecoration(
                  suffix: suffixWidget ?? const SizedBox(),
                  hintText: hint,
                    errorStyle: const TextStyle(fontSize: 0, height: 0, color: Colors.transparent),
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                    contentPadding: EdgeInsets.zero,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondDefaultColor,width: 2)
                    ),
                    errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondDefaultColor,width: 2)
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: secondDefaultColor,width: 2)
                    )
                ),
              ),
            ),
            widget == null  ? const SizedBox() :  SizedBox(width: 10.w,),
            widget ?? const SizedBox()
          ],
        ),
      ],
    ),
  );
}

Widget newTaskCatList(context)
{
  return SizedBox(
    height: 4.5.h,
    child: NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {overScroll.disallowIndicator();return true;},
      child: ListView.builder(
          padding: EdgeInsets.only(left: 7.w, right: 1.w),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              onTap: ()
              {
                AppCubit.get(context).newTaskCatChangeIndex(index);
                category = AppCubit.get(context).newTaskCategories[index];
                print(category);
              },
              child: Container(
                alignment: AlignmentDirectional.center,
                padding: const EdgeInsets.all(8),
                height: 4.h,
                decoration: BoxDecoration(
                    color: AppCubit.get(context).changeColor(index: index),
                    borderRadius: BorderRadius.circular(6),
                    border: AppCubit.get(context).changeBorderColor(index: index)
                ),
                child: Text(AppCubit.get(context).newTaskCategories[index], style: Theme.of(context).textTheme.caption?.copyWith(
                    height: 1.2,
                    fontSize: 12,
                    color: AppCubit.get(context).selectIndex == index ? Colors.white : AppCubit.get(context).darkMode == true ? Colors.grey : secondDefaultColor,
                    fontWeight: FontWeight.w600),),
              ),
            ),
          ),
          itemCount: AppCubit.get(context).newTaskCategories.length),
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
  const ReusableTextButton({Key? key, this.buttonText, this.onPressed, required this.color, required this.textColor, this.borderSide, this.radius = 8, this.horizontal = 0,required this.fontSize,required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      height: height,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius), // <-- Radius
              ),
              backgroundColor: color,
              side: borderSide ?? null,
              alignment: AlignmentDirectional.center
          ),
          onPressed: onPressed, child:  Text(
        buttonText!,style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: fontSize,fontFamily: 'Oswald-Bold',color: textColor),)),
    );
  }
}

showTimePicked(context)
{
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),).then((value) {
    var day = AppCubit.get(context).todayDateBeforeFormat;
    AppCubit.get(context).startTimeController!.text =  DateFormat('hh:mm a').format(DateTime(day.year, day.month, day.day, value!.hour, value.minute));
    AppCubit.get(context).startAndEndTimeValidation = DateTime(day.year, day.month, day.day, value.hour, value.minute);
  }
  ).catchError((error){print(error.toString());});
}

showEndTimePicker({context})
{
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  ).then((value)
  {
    var day = AppCubit.get(context).todayDateBeforeFormat;
    print(value);
    print(day);
    if(DateTime(day.year, day.month, day.day, value!.hour, value.minute).isAfter(AppCubit.get(context).startAndEndTimeValidation))
    {
      AppCubit.get(context).endTimeController!.text =  DateFormat('hh:mm a').format(DateTime(day.year, day.month, day.day, value.hour, value.minute));
    }
    else{
      print('Error');
      AppCubit.get(context).endTimeController!.text = DateFormat('hh:mm a').format(AppCubit.get(context).startAndEndTimeValidation.add(const Duration(hours: 1)));
      snackBar(
          context: context,
          backgroundColor: Colors.red,
          barBehavior: SnackBarBehavior.floating,
          seconds: 3,
          text: 'The end time should be after the start time');
    }
  }
  );
}

Widget emptyWidget()
{
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
      listener: (context, state) {
      },
      builder: (context, state) {
        return Text(TimeCubit.get(context).streamTime, style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18.sp, color: Colors.white));
      },
    );
  }
}

class ReusableDrawerButton extends StatelessWidget {
  final String text;
  final IconData prefixIcon;
  final void Function()? onPressed;
  const ReusableDrawerButton({Key? key, required this.text, required this.prefixIcon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onPressed,
      height: 50,
      padding: EdgeInsets.only(left: 10, bottom: 5, top: 5,right: 4.w),
      child: Row(
        children:
        [
          Text(text, style: const TextStyle(fontSize: 18, fontFamily: 'AsapCondensed-Bold',color: Colors.white),),
          const Spacer(),
          Icon(prefixIcon,size: 25,color: Colors.white,),
        ],
      ),
    );
  }
}

showModelSheet({context, required Task task}){
  return showModalBottomSheet(
      elevation: 5,
      isDismissible: true,
      context: context,
      builder: (context)
  {
    return Container(
      width: double.infinity,
      height: 23.h,
      padding: const EdgeInsets.all(4),
      color: AppCubit
          .get(context)
          .darkMode == false ? Colors.white : darkThemeColor1,
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 0.5.h,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15)
            ),
          ),
          SizedBox(height: 4.h,),
          ReusableTextButton(
            height: 6.8.h,
            color: Colors.red,
            textColor: Colors.white,
            buttonText: 'Delete',
            onPressed: () {
              AppCubit.get(context).deleteTask(task);
              Navigator.pop(context);
            },
            horizontal: 9.w,
            radius: 100,
            fontSize: 20.sp,
          ),
          SizedBox(height: 2.h,),
          ReusableTextButton(
            height: 6.8.h,
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            color: AppCubit
                .get(context)
                .darkMode == false ? Colors.grey[300]! : Colors.grey[600]!,
            textColor: AppCubit
                .get(context)
                .darkMode == false ? Colors.black : Colors.white,
            buttonText: 'Cancel',
            onPressed: () {
              Navigator.pop(context);
            },
            horizontal: 8.w,
            radius: 100,
            fontSize: 20.sp,
          ),
          SizedBox(height: 1.h,),
        ],
      ),
    );
  }
  );
}
