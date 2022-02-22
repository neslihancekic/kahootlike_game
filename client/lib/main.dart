import 'dart:async';

import 'package:flutter/services.dart';
import 'package:kahootlike_game/services/game_service.dart';
import 'package:kahootlike_game/services/leaderboard_service.dart';
import 'package:kahootlike_game/services/network/api_service.dart';
import 'package:kahootlike_game/services/upload_service.dart';
import 'package:kahootlike_game/services/user_service.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/generic.dart/actions.dart';
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
    runApp(const MainWidget());
  }, (error, stackTrace) async {});
}

Future initServices() async {
  Get.put(ApiService());
  Get.put(UserService());
  Get.put(GameService());
  Get.put(UploadService());
  Get.put(LeaderboardService());
}

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);
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
        getPages: [GetPage(name: "/", page: () => const MainPage())],
        navigatorObservers: []);
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [const OpenningPage()];

    Future<bool> _onWillPop() async {
      return false;
    }

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: pages.first,
        ));
  }
}
