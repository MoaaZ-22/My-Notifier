import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import 'package:my_task/shared/cubit/cubit.dart';
import 'package:my_task/shared/cubit/states.dart';
import 'package:my_task/shared/styles/colors.dart';
import 'package:sizer/sizer.dart';
import '../../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
    return BlocConsumer<AppCubit, AppStates>(
    listener: (context, state) {
    },
    builder: (context, state) {
      SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    var appCubit = AppCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: ()
        {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            backgroundWidget(context: context),
            homeTopWidget(context),
            homeBottomWidget(context),
            appCubit.lang == 'en' ?
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
            ) :
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
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
                        child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: const UpdatedTime()))
                  ],
                ),
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

