// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_task/shared/cubit/cubit.dart';
import 'package:my_task/shared/styles/iconly.dart';
import 'package:sizer/sizer.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).startTimeController!.text = DateFormat('hh:mm a').format(DateTime.now());
    AppCubit.get(context).endTimeController!.text =  DateFormat('hh:mm a').format(DateTime.now().add(const Duration(hours: 1)));
    final formKey = GlobalKey<FormState>();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var appCubit = AppCubit.get(context);
        appCubit.dateController!.text = DateFormat('EEEE, dd MMMM').format(appCubit.todayDateBeforeFormat);
        return GestureDetector(
          onTap: ()
          {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: newTaskAppBar(context: context, leadingFunc: () {Navigator.pop(context);appCubit.controllersClear();}, actionsFunc: () {}),
            backgroundColor: AppCubit.get(context).darkMode ==  false ? Colors.white : darkThemeColor1,
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 4.h),
              child: ReusableTextButton(
                height: 8.8.h,
                fontSize: 28.sp,
                color: Colors.blue,
                textColor: Colors.white,
                buttonText: 'Create Task',
                onPressed: ()
                {
                  appCubit.buttonFunc(formKey: formKey, context: context);
                },
              ),
            ),
            extendBody: false,
            body: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 3.h),
              scrollDirection: Axis.vertical,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 3.3.w, left: 7.w),
                      child: Row(
                        children: [
                          Text(
                            'Create New Task',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontSize: 28),
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
                        title: 'Task Name',
                        controller: appCubit.taskNameController,
                        hint: 'Write your task title',
                        readOnly: false,
                        validator: (value) =>
                            appCubit.createNewTaskValidation(value)),
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 7.w),
                      child: Text('Select Categories', style: Theme.of(context).textTheme.headline6?.copyWith(color: secondDefaultColor, fontSize: 18),),
                    ),
                    SizedBox(height: 2.h,),
                    newTaskCatList(context),
                    defaultTextFormFiled(
                      keyboardType: TextInputType.datetime,
                      context: context,
                      title: 'Date',
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
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: defaultTextFormFiled(
                              keyboardType: TextInputType.none,
                              title: 'Start Time',
                              context: context,
                              readOnly: true,
                              suffixWidget: IconButton(
                                padding: EdgeInsets.zero,
                                splashRadius: 24,
                                onPressed: () {showTimePicked(context);},
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
                              title: 'End Time',
                              context: context,
                              readOnly: true,
                              suffixWidget: IconButton(
                                splashRadius: 24,
                                onPressed: () {showEndTimePicker(context: context);},
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
                        title: 'Description',
                        context: context,
                        hint: 'Write here your description',
                        controller: appCubit.descriptionController,
                        validator: (value) =>
                            appCubit.createNewTaskValidation(value)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
