import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/create_new_game/new_game.dart';
import 'package:kahootlike_game/views/create_new_game/new_question.dart';
import 'package:kahootlike_game/views/generic.dart/actions.dart';
import 'package:kahootlike_game/views/generic.dart/base.dart';
import 'package:kahootlike_game/views/generic.dart/templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/../main.dart';

class TimeLimitPopup extends StatelessWidget {
  const TimeLimitPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewGamePageController controller = Get.put(NewGamePageController(context));
    return Scaffold(
        primary: false,
        backgroundColor: AppTheme.white.withOpacity(0),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(navigatorKey.currentContext!)!
                          .timeLimit,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: AppTheme.headerFontsize26,
                          color: AppTheme.white),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: GridView.count(
                        primary: false,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 1.5,
                        children: const <Widget>[
                          TimeLimitCard(limit: 5),
                          TimeLimitCard(limit: 10),
                          TimeLimitCard(limit: 20),
                          TimeLimitCard(limit: 30),
                          TimeLimitCard(limit: 60),
                          TimeLimitCard(limit: 90),
                          TimeLimitCard(limit: 120),
                          TimeLimitCard(limit: 240)
                        ]),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 58,
                        decoration: BoxDecoration(
                            color: AppTheme.blue,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [CustomBoxShadow()]),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            AppLocalizations.of(navigatorKey.currentContext!)!
                                .done,
                            style: const TextStyle(
                                fontSize: AppTheme.bodyFontsize15,
                                color: AppTheme.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ]));
  }
}

class TimeLimitCard extends StatelessWidget {
  final int limit;
  const TimeLimitCard({Key? key, required this.limit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async => {},
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.border),
                boxShadow: [CustomBoxShadow()]),
            child: Text(
              limit.toString() +
                  " " +
                  AppLocalizations.of(navigatorKey.currentContext!)!.sec,
              maxLines: 2,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: AppTheme.bodyFontsize15,
                  color: AppTheme.surface3),
            )));
  }
}
