// ignore_for_file: depend_on_referenced_packages
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:my_task/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../Home_Screen/task_item.dart';
import 'package:timezone/timezone.dart' as tz;

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);
    var taskList =  AppCubit.get(context).taskList;
    return Scaffold(
      backgroundColor: appCubit.darkMode == false ? Colors.white : darkThemeColor1,
      appBar: historyAppBar(context:context, leadingFunc: (){Navigator.pop(context);}),
      body: ConditionalBuilder(
        condition: taskList!.isNotEmpty,
        builder: (context) => Scrollbar(
          scrollbarOrientation: ScrollbarOrientation.left,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(left:2.h, top: 3.h, right: 2.h, bottom: 5.h),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index)
              {
                var task = AppCubit.get(context).taskList![index];
                var taskHistoryDate = DateFormat.yMMMEd(appCubit.lang).format(taskList[index].date);
                final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
                tz.TZDateTime taskDate = tz.TZDateTime(tz.local,task.date.year, task.date.month, task.date.day,);
                if (taskDate.isBefore(tz.TZDateTime(tz.local, now.year, now.month, now.day,))) {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: TaskItem(
                            taskId: appCubit.keys![index],
                            model: taskList[index],
                            historyText: '$taskHistoryDate  -  ',
                            width: 60.w, fontSize: 13.sp, border: Border.all(color: Colors.blueGrey, width: 1),),
                        ),
                      )
                  );
                }
                else
                {
                  return  Container();
                }
              },
              itemCount: AppCubit.get(context).taskList!.length
          ),
        ),
        fallback: (context) => emptyWidget(),
      ),
    );
  }
}
