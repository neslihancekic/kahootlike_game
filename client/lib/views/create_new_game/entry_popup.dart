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

class EntryPopup extends StatelessWidget {
  final String title;
  final int count;
  final Function onEditingComplete;
  const EntryPopup(
      {Key? key,
      required this.title,
      required this.count,
      required this.onEditingComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewGamePageController controller = Get.put(NewGamePageController(context));
    return Scaffold(
        primary: false,
        backgroundColor: AppTheme.white.withOpacity(0),
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: AppTheme.bodyFontsize15,
                          color: AppTheme.white),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        border: Border.all(color: AppTheme.border),
                        boxShadow: [CustomBoxShadow()]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              count.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppTheme.footnoteFontsize13,
                                  color: AppTheme.surface3),
                            ),
                          ),
                          CustomEntry(
                              AppLocalizations.of(navigatorKey.currentContext!)!
                                  .title,
                              controller.entryController,
                              controller.entryFocusNode,
                              onEditingComplete: () =>
                                  {onEditingComplete.call(), Get.back()},
                              maxLength: 120,
                              fontSize: AppTheme.body2Fontsize18,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              boxDecoration:
                                  const BoxDecoration(color: AppTheme.white),
                              height: 35,
                              autoFocus: true)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ))
        ]));
  }
}
