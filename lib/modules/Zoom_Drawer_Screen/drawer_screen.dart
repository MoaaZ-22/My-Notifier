import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:my_task/modules/Home_Screen/home_screen.dart';
import 'package:my_task/shared/cubit/cubit.dart';
import 'package:my_task/shared/cubit/states.dart';
import 'package:sizer/sizer.dart';
import '../Menu_Screen/menu_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:AppCubit.get(context).darkMode ==  false ? [
                  Colors.blue[400]!,
                  Colors.blue[800]!,
                ] : [Colors.grey[700]!, Colors.grey[800]!,],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )
          ),
          child: ZoomDrawer(
            shrinkMainScreen: false,
              moveMenuScreen: true,
              angle: 0.0,
              borderRadius: 30,
              slideWidth: 60.w,
              showShadow: true,
              shadowLayer1Color: Colors.transparent,
              duration: const Duration(milliseconds: 200),
              mainScreen: const HomeScreen(),
              menuScreen: const MenuScreen(),
              ),
        );
      },
    );
  }
}
