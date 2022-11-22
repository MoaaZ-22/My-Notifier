import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sizer/sizer.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../History_Screen/history_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReusableDrawerButton(text: 'History', prefixIcon: Icons.history,onPressed: (){
                navigateTo(context, const HistoryScreen());
                ZoomDrawer.of(context)!.close();
              },),
              Container(
                padding:  EdgeInsets.only(left: 3.w, bottom: 5, top: 5),
                child: Row(
                  children: [
                    const Text('Dark Mode',style:TextStyle(fontSize: 18, fontFamily: 'AsapCondensed-Bold',color: Colors.white)),
                    const Spacer(),
                    Switch(
                      value: AppCubit.get(context).darkMode,
                      onChanged: (value){
                        AppCubit.get(context).changeAppMode();
                      },
                      activeColor: AppCubit.get(context).darkMode == false ? Colors.grey : Colors.white,
                      activeTrackColor: defaultColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: darkThemeColor1,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}