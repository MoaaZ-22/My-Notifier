// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_task/shared/components/components.dart';
import 'package:my_task/shared/network/local/notification_helper.dart';
import 'package:my_task/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';
import '../../models/task.dart';
import '../../shared/cubit/cubit.dart';


class TaskItem extends StatelessWidget {
  final Task model;
  final int taskId;
  final String? historyText;
  final double? width;
  final double? fontSize;
  final BoxBorder? border;
  const TaskItem({Key? key, required this.model, this.historyText = '', required this.width,required this.fontSize, this.border, required this.taskId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var translatedTime = DateFormat('hh:mm a', AppCubit.get(context).lang).format(model.startTime);
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        showModelSheet(context: context, task: model);
        NotifyHelper().deleteNotification(taskId: taskId);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        height: 20.5. h,
        child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children:
            [
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 10,
                  child: Container(
                    height: 18.h,
                    width: double.infinity,
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                      border: border ?? null,
                      color: AppCubit.get(context).darkMode ==  false ? Colors.white : const Color(0xff424242),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 5.h,
                          backgroundColor: Colors.blue.shade200,
                          child: Align(
                              alignment: AlignmentDirectional.center,
                              child: categoriesIcon(category: model.category)),
                        ),
                        SizedBox(width: 2.h,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            SizedBox(
                              width: 40.w,
                              child: Text(model.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20,fontFamily: 'AsapCondensed-Bold', color: AppCubit.get(context).darkMode ==  false ? Colors.black : Colors.white,
                                ),),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                              width: 40.w,
                              child: Text(model.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.caption?.copyWith(
                                    height: 1.2,
                                    fontFamily: 'AsapCondensed-Bold',fontSize: 16,color: Colors.blue.shade200),),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                width: width,
                height: 5.5.h,
                decoration: BoxDecoration(
                    color: AppCubit.get(context).darkMode == false ? Colors.black : secondDefaultColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
                child: Text('$historyText$translatedTime', style: TextStyle(fontSize: fontSize, fontFamily: 'AsapCondensed-Bold', color: Colors.white),),
              )
            ]
        ),
      ),
    );
  }
}
