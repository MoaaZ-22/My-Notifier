import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task/shared/components/app_localization.dart';
import 'package:sizer/sizer.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appCubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
          appCubit.darkMode == false ? Colors.white : darkThemeColor2,
          appBar: AppBar(
            shape: Border(
                bottom: BorderSide(color: secondDefaultColor, width: 1)),
            backgroundColor:
            appCubit.darkMode == false ? Colors.white : darkThemeColor2,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              splashRadius: 25,
              onPressed: (){Navigator.pop(context);},
              padding: EdgeInsets.only(right: 2.5.w),
              icon: Icon(
                Icons.arrow_back_ios,
                color: appCubit.darkMode == false ? Colors.black : Colors
                    .grey,
                size: 24,
              ),
            ),
            title: Text(
              'settings'.tr(context),
              style: TextStyle(
                color: appCubit.darkMode == false ? Colors.black : Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                left: 20, bottom: 5, top: 5, right: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('darkMode'.tr(context),
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'AsapCondensed-Bold',
                          color: appCubit.darkMode == false
                              ? Colors.black
                              : Colors.white,
                        )),
                    const Spacer(),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Switch(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: appCubit.darkMode,
                        onChanged: (value) {
                          appCubit.changeAppMode();
                        },
                        activeColor: appCubit.darkMode == false
                            ? darkThemeColor1
                            : Colors.white,
                        activeTrackColor: appCubit.darkMode == false
                            ? Colors.white
                            : darkThemeColor1,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: darkThemeColor1,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('language'.tr(context),
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'AsapCondensed-Bold',
                          color: appCubit.darkMode == false
                              ? Colors.black
                              : Colors.white,
                        )),
                    const Spacer(),
                    DropdownButton(
                      underline: Container(
                        width: double.infinity,
                        height: 1,
                        color: appCubit.darkMode == false
                            ? Colors.black
                            : Colors.white,
                      ),
                      dropdownColor: appCubit.darkMode == false ? Colors.white
            : darkThemeColor1,
                      value: appCubit.lang,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: appCubit.darkMode == false
                            ? Colors.black
                            : Colors.white,
                      ),
                      items: appCubit.dropDownButton.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items.toUpperCase(), style: TextStyle(color:appCubit.darkMode == false
                              ? Colors.black
                              : Colors.white, ),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        appCubit.changeLanguage(value!);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
