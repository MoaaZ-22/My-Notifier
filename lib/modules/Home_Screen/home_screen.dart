import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:my_task/modules/Home_Screen/task_item.dart';
import 'package:my_task/modules/New_Task_Screen/new_task.dart';
import 'package:my_task/shared/cubit/cubit.dart';
import 'package:my_task/shared/cubit/states.dart';
import 'package:my_task/shared/network/local/notification_helper.dart';
import 'package:my_task/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/iconly.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var notifyHelper = NotifyHelper();
    DateTime now = DateTime.now();
    String? date = DateFormat('EEEE, dd MMMM').format(now);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return BlocConsumer<AppCubit, AppStates>(
    listener: (context, state) {},
    builder: (context, state) {
    var appCubit = AppCubit.get(context);
    var taskList = AppCubit.get(context).taskList;
    return Scaffold(
      body: GestureDetector(
        onTap: ()
        {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            backgroundWidget(context: context),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.45,
              padding: EdgeInsets.only(top: 3.h),
              decoration: BoxDecoration(
                  color: AppCubit.get(context).darkMode == false? Colors.white : darkThemeColor1,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40))
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                      MaterialButton(
                        height: 6.h,
                        minWidth: 0,
                        padding: const EdgeInsets.all(3),
                        shape: const CircleBorder(),
                        onPressed: () {
                          ZoomDrawer.of(context)?.toggle();
                        },
                        child:  Icon(Icons.menu_rounded,
                            color: appCubit.darkMode ==  false ? Colors.black : Colors.grey, size: 30),),
                      MaterialButton(
                        height: 6.h,
                        minWidth: 0,
                        padding: const EdgeInsets.all(3),
                        shape: const CircleBorder(),
                        onPressed: ()
                        {
                          // ToDo : Delete
                          notifyHelper.displayNotification(title: 'MoaaZ Notification',
                              body: 'Done Ya M3lem',
                          );
                        },
                        child: Icon(IconlyBroken.notification, color: appCubit.darkMode ==  false ? defaultColor : Colors.grey,size: 30),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.8.h,left: MediaQuery.of(context).size.width*0.07, right: MediaQuery.of(context).size.width*0.07),
                    child: Row(
                      children: [
                        Text('My Task', style: Theme.of(context).textTheme.bodyText1,),
                        const Spacer(),
                        MaterialButton(
                          minWidth: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          padding: const EdgeInsets.all(12),
                          color: Colors.blue,
                          onPressed: (){
                            navigateTo(context, const NewTaskScreen());
                          },
                          child: const Icon(Icons.add ,color: Colors.white,),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.03, left: MediaQuery.of(context).size.width*0.07, right: MediaQuery.of(context).size.width*0.07),
                    child: Row(
                      children: [
                        Text('Today', style: TextStyle(fontFamily: 'AsapCondensed-Medium', fontSize: 20, color: appCubit.darkMode ==  false ? Colors.black : Colors.grey),),
                        const Spacer(),
                        // ToDo : Change Date Every Day
                        Text(date, style: Theme.of(context).textTheme.caption?.copyWith(fontFamily: 'Oswald-Regular', color: appCubit.darkMode ==  false ? Colors.black : Colors.grey),)
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  dateBar(now, context)
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.55,
                decoration: BoxDecoration(
                    color: appCubit.darkMode ==  false ? Colors.blue : darkThemeColor2,
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(40))
                ),
                child: ConditionalBuilder(
                  condition: taskList!.isNotEmpty,
                  builder: (context) => Scrollbar(
                    scrollbarOrientation: ScrollbarOrientation.left,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left:5.h, top: 5.h, right: 4.h, bottom: 5.h),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index)
                        {
                          var task = AppCubit.get(context).taskList![index];
                          DateTime start = DateFormat.jm().parse(task.startTime);

                          // 10 min Before task start time
                          var notificationTime = DateFormat('HH:mm').format(start);
                          notifyHelper.scheduledNotification(
                              hour: int.parse(notificationTime.split(':')[0]),
                              minutes: int.parse(notificationTime.split(':')[1]),
                              task: task);

                          notifyHelper.scheduledNotification2(
                              hour: int.parse(notificationTime.split(':')[0]),
                              minutes: int.parse(notificationTime.split(':')[1]),
                              task: task);

                          if (DateFormat('EEEE, dd MMMM').format(task.date) == DateFormat('EEEE, dd MMMM').format(AppCubit.get(context).todayDateBeforeFormat)) {
                            return AnimationConfiguration.staggeredList(
                                position: index,
                                child: SlideAnimation(
                                  child: FadeInAnimation(
                                    child: TaskItem(model: taskList[index],width: 30.w,fontSize: 15.3.sp,),
                                  ),
                                )
                            );
                          }
                          else {
                            return  Container();
                          }
                        },
                        itemCount: AppCubit.get(context).taskList!.length
                    ),
                  ),
                  fallback: (context) => emptyWidget(),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width*0.56,(MediaQuery.of(context).size.height*0.17).toDouble()),
                    painter: RPSCustomPainter(appCubit.darkMode == false ? Colors.blue : darkThemeColor2!),
                  ),
                  Positioned(
                      top: 4.5.h,
                      right: 4.5.w,
                      child: const UpdatedTime())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}

