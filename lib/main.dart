import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_task/models/task.dart';
import 'package:my_task/modules/Home_Screen/TimeCubit/time_cubit.dart';
import 'package:my_task/modules/Zoom_Drawer_Screen/drawer_screen.dart';
import 'package:my_task/shared/bloc_observer.dart';
import 'package:my_task/shared/cubit/cubit.dart';
import 'package:my_task/shared/cubit/states.dart';
import 'package:my_task/shared/network/local/cache_helper.dart';
import 'package:my_task/shared/network/local/notification_helper.dart';
import 'package:my_task/shared/network/remote/dio_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(TaskAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Task>('task');
  DioHelper.init();
  await CacheHelper.init();
  await NotifyHelper().init();
  NotifyHelper().requestIOSPermissions();
  bool ? darkMode = CacheHelper.getDataIntoShPre(key: "isDark");
  Bloc.observer = MyTaskBlocObserver();
  runApp(MyTask(darkMode: darkMode,));
}

class MyTask extends StatelessWidget {
  final bool? darkMode;
  const MyTask({super.key, required this.darkMode});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) => AppCubit()..getBox()..changeAppMode(fromShared: darkMode),),
        BlocProvider(create: (context) => TimeCubit()..showUpdatedTime(),)
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          return Sizer(
              builder: (context, orientation, deviceType) {
                return MaterialApp(
                  navigatorKey: navigatorKey,
                  debugShowCheckedModeBanner: false,
                  home: const DrawerScreen(),
                  theme: ThemeData(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    textTheme: const TextTheme(
                        bodyText1: TextStyle(fontSize: 30,fontFamily: 'AsapCondensed-Bold', color: Colors.black),
                        bodyText2: TextStyle(fontSize: 12, fontFamily: 'AsapCondensed-Medium')
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      mainAxisMargin: 4.5.h,
                      thumbColor: MaterialStateProperty.all(Colors.black54),
                      minThumbLength: 12.h,
                      trackBorderColor: MaterialStateProperty.all(Colors.white),
                      trackColor: MaterialStateProperty.all(Colors.white),
                      trackVisibility: MaterialStateProperty.all(true),
                      interactive: true,
                      thumbVisibility: MaterialStateProperty.all(true),
                      thickness: MaterialStateProperty.all(5),
                    ),
                  ),
                  darkTheme: ThemeData(
                    textTheme: const TextTheme(
                        bodyText1: TextStyle(fontSize: 30,fontFamily: 'AsapCondensed-Bold', color: Colors.white)
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      mainAxisMargin: 4.5.h,
                      thumbColor: MaterialStateProperty.all(Colors.black54),
                      minThumbLength: 12.h,
                      trackBorderColor: MaterialStateProperty.all(Colors.white),
                      trackColor: MaterialStateProperty.all(Colors.white),
                      trackVisibility: MaterialStateProperty.all(true),
                      interactive: true,
                      thumbVisibility: MaterialStateProperty.all(true),
                      thickness: MaterialStateProperty.all(5),
                    ),
                  ),
                  themeMode: AppCubit.get(context).darkMode == true ? ThemeMode.dark : ThemeMode.light,
                );
              }
          );
        },
      ),
    );
  }
}
