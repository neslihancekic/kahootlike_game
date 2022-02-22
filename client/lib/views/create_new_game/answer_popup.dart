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

class AnswerPopup extends StatelessWidget {
  final Color color;
  final int index;
  final int questionIndex;
  final Function onEditingComplete;
  const AnswerPopup(
      {Key? key,
      required this.color,
      required this.index,
      required this.questionIndex,
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
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: (MediaQuery.of(context).size.width - 220) / 2),
                      child: Text(
                        AppLocalizations.of(navigatorKey.currentContext!)!
                            .addAnswer,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppTheme.bodyFontsize15,
                            color: AppTheme.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [CustomBoxShadow()]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              (75 - controller.entryController.text.length)
                                  .toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppTheme.footnoteFontsize13,
                                  color: AppTheme.white),
                            ),
                          ),
                          CustomEntry(
                              AppLocalizations.of(navigatorKey.currentContext!)!
                                  .title,
                              controller.entryController,
                              controller.entryFocusNode,
                              onEditingComplete: () =>
                                  {onEditingComplete.call(), Get.back()},
                              textColor: AppTheme.white,
                              maxLength: 75,
                              fontSize: AppTheme.body2Fontsize18,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              boxDecoration: BoxDecoration(color: color),
                              height: 100,
                              autoFocus: true)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [CustomBoxShadow()]),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(navigatorKey.currentContext!)!
                                .correctAnswer,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: AppTheme.bodyFontsize15,
                                color: AppTheme.surface3),
                          ),
                          Obx(() => Switch(
                              value: controller
                                  .game
                                  .value
                                  .questions![questionIndex]
                                  .choices![index]
                                  .isCorrectAnswer!,
                              onChanged: (x) {
                                controller.game.value.questions![questionIndex]
                                    .choices![index].isCorrectAnswer = x;
                                controller.game.refresh();
                              }))
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ]));
  }
}
