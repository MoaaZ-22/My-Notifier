// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_task/shared/components/components.dart';
import 'package:sizer/sizer.dart';
import '../../models/task.dart';
import '../../shared/cubit/cubit.dart';


class TaskItem extends StatelessWidget {
  final Task model;
  final String? historyText;
  final double? width;
  final double? fontSize;
  final BoxBorder? border;
  const TaskItem({Key? key, required this.model, this.historyText = '', required this.width,required this.fontSize, this.border}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        showModelSheet(context: context, task: model);
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
                          child: model.category == "Development" ? SvgPicture.asset(
                              height: 6.h,
                              width: 10.w,
                              'assets/images/mobile_development.svg') : SvgPicture.asset('assets/images/server.svg'),
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
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
                child: Text('$historyText${model.startTime}', style: TextStyle(fontSize: fontSize, fontFamily: 'AsapCondensed-Bold', color: Colors.white),),
              )
            ]
        ),
      ),
    );
  }
}
