import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:my_task/modules/Settings_Screen/settings_screen.dart';
import 'package:my_task/shared/components/app_localization.dart';
import 'package:my_task/shared/styles/iconly.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../History_Screen/history_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: AppCubit.get(context).darkMode == false
                ? [
                    Colors.blue[400]!,
                    Colors.blue[800]!,
                  ]
                : [
                    Colors.grey[700]!,
                    Colors.grey[800]!,
                  ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReusableDrawerButton(
                text: 'history'.tr(context),
                prefixIcon: Icons.history,
                onPressed: () {
                  navigateTo(context, const HistoryScreen());
                  ZoomDrawer.of(context)!.close();
                },
              ),
              ReusableDrawerButton(
                text: 'settings'.tr(context),
                prefixIcon: IconlyBroken.setting,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ));
                  ZoomDrawer.of(context)!.close();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
