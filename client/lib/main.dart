import 'dart:async';

import 'package:flutter/services.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/openning.dart';
import 'package:leak_detector/leak_detector.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  runZonedGuarded(() async {
    await initServices();
    WidgetsFlutterBinding.ensureInitialized();
    LeakDetector().init(maxRetainingPath: 300);
    LeakDetector().onLeakedStream.listen((LeakedInfo info) {
      //print to console
      info.retainingPath.forEach((node) => print(node));
      //show preview page
      showLeakedInfoPage(navigatorKey.currentContext!, info);
    });

    runApp(const MainPage());
  }, (error, stackTrace) async {});
}

Future initServices() async {
  //Get.put(EmployeeService());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          const Locale('en', ''), // English, no country code
          const Locale('tr', ''), // Turkish, no country code
        ],
        navigatorKey: navigatorKey,
        title: 'Kahootlike Game',
        theme: ThemeData(
            primaryColor: AppTheme.primary,
            scaffoldBackgroundColor: AppTheme.surface1),
        initialRoute: '/',
        getPages: [GetPage(name: "/", page: () => const OpenningPage())],
        navigatorObservers: [
          LeakNavigatorObserver(
            shouldCheck: (route) {
              return route.settings.name != null && route.settings.name != '/';
            },
          ),
        ]);
  }
}
