import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_task/models/task.dart';
import 'package:my_task/modules/Home_Screen/TimeCubit/time_cubit.dart';
import 'package:my_task/modules/Zoom_Drawer_Screen/drawer_screen.dart';
import 'package:my_task/shared/bloc_observer.dart';
import 'package:my_task/shared/components/app_localization.dart';
import 'package:my_task/shared/components/const.dart';
import 'package:my_task/shared/cubit/cubit.dart';
import 'package:my_task/shared/cubit/states.dart';
import 'package:my_task/shared/network/local/cache_helper.dart';
import 'package:my_task/shared/network/local/notification_helper.dart';
import 'package:my_task/shared/styles/themes.dart';
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
  await CacheHelper.init();
  await NotifyHelper().init();
  NotifyHelper().requestIOSPermissions();
  bool ? darkMode = CacheHelper.getDataIntoShPre(key: "isDark");
  lang = CacheHelper.getDataFromShPre(key: 'Lang');
  Bloc.observer = MyTaskBlocObserver();

  if(lang != null)
  {
    lang = lang;
  }
  else {
    lang = 'en';
  }

  runApp(MyTask(darkMode: darkMode, lang: lang,));
}

class MyTask extends StatelessWidget {
  final bool? darkMode;
  final String? lang;
  const MyTask({super.key, required this.darkMode,required this.lang});


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) => AppCubit()..getBox()..changeAppMode(fromShared: darkMode)..changeLanguage(lang!),),
        BlocProvider(create: (context) => TimeCubit()..showUpdatedTime(),)
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          return Sizer(
              builder: (context, orientation, deviceType) {
                return MaterialApp(
                  locale: AppCubit.get(context).lang == 'en'  ? const Locale('en') : const Locale('ar'),
                  supportedLocales:
                  const
                  [

                    Locale('en'),
                    Locale('ar')

                  ],

                  localizationsDelegates:
                  const [

                    AppLocalization.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate

                  ],
                  localeResolutionCallback: (deviceLocal, supportedLocal)
                  {

                    for(var local in supportedLocal)
                      {
                        if(deviceLocal != null && deviceLocal.languageCode == local.languageCode)
                        {
                          return deviceLocal;
                        }
                      }

                    return supportedLocal.first;
                  },

                  navigatorKey: navigatorKey,
                  debugShowCheckedModeBanner: false,
                  home: const DrawerScreen(),
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: AppCubit.get(context).darkMode == true ? ThemeMode.dark : ThemeMode.light,
                );
              }
          );
        },
      ),
    );
  }
}
