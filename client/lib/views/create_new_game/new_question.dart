import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahootlike_game/utils/constants.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/create_new_game/answer_popup.dart';
import 'package:kahootlike_game/views/create_new_game/entry_popup.dart';
import 'package:kahootlike_game/views/create_new_game/new_game.dart';
import 'package:kahootlike_game/views/create_new_game/time_limit_popup.dart';
import 'package:kahootlike_game/views/generic.dart/actions.dart';
import 'package:kahootlike_game/views/generic.dart/base.dart';
import 'package:kahootlike_game/views/generic.dart/templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/../main.dart';

class NewQuestionPage extends StatelessWidget {
  final int index;
  const NewQuestionPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewGamePageController controller = Get.find();
    final node = FocusScope.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: AppTheme.white,
          child: SafeArea(
              child: Column(
            children: [
              Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border.all(color: AppTheme.border),
                      boxShadow: [CustomBoxShadow()]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(Icons.chevron_left,
                                  color: AppTheme.primary)),
                          const Text(
                            'Kahootlike Game',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: AppTheme.body2Fontsize18,
                                color: AppTheme.primary),
                          ),
                          const SizedBox(
                            width: 50,
                            child: Text(
                              "",
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppTheme.bodyFontsize15,
                                  color: AppTheme.surface3),
                            ),
                          ),
                        ]),
                  )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          var url = await controller.uploadGamePhoto();
                          controller
                              .game.value.questions![index].questionPhoto = url;
                        },
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppTheme.white,
                                border: Border.all(color: AppTheme.border),
                                boxShadow: [CustomBoxShadow()]),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.image_outlined,
                                    color: AppTheme.surface3,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    AppLocalizations.of(
                                            navigatorKey.currentContext!)!
                                        .addCoverPhoto,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: AppTheme.body2Fontsize18,
                                        color: AppTheme.surface3),
                                  ),
                                ])),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () async => {
                          await showPopup(
                              context: context,
                              backgroundOpacity: 0.8,
                              child: const TimeLimitPopup())
                        },
                        child: Container(
                          width: 88,
                          decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: AppTheme.border),
                              boxShadow: [CustomBoxShadow()]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(Icons.timelapse, color: AppTheme.white),
                                SizedBox(width: 5),
                                Text(
                                  "20 sn",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: AppTheme.bodyFontsize15,
                                      color: AppTheme.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    InkWell(
                      onTap: () async => {
                        controller.entryController.text = controller
                                .game.value.questions![index].questionText ??
                            "",
                        await showPopup(
                            context: context,
                            child: EntryPopup(
                                title: AppLocalizations.of(
                                        navigatorKey.currentContext!)!
                                    .question,
                                onEditingComplete: () => {
                                      controller.game.value.questions![index]
                                              .questionText =
                                          controller.entryController.text,
                                      controller.entryController.text = ""
                                    },
                                count: 120))
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            border: Border.all(color: AppTheme.border),
                            boxShadow: [CustomBoxShadow()]),
                        child: Text(
                          controller
                                  .game.value.questions![index].questionText ??
                              AppLocalizations.of(navigatorKey.currentContext!)!
                                  .question,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: AppTheme.bodyFontsize15,
                              color: AppTheme.surface3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GridView.count(
                        primary: false,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 1.5,
                        children: <Widget>[
                          QuestionCard(
                            color: AppTheme.red,
                            index: 0,
                            questionIndex: index,
                          ),
                          QuestionCard(
                            color: AppTheme.blue,
                            index: 1,
                            questionIndex: index,
                          ),
                          QuestionCard(
                            color: AppTheme.yellow,
                            isOptional: true,
                            index: 2,
                            questionIndex: index,
                          ),
                          QuestionCard(
                            color: AppTheme.success,
                            isOptional: true,
                            index: 3,
                            questionIndex: index,
                          ),
                        ]),
                    const SizedBox(height: 15),
                  ],
                ),
              )),
            ],
          )),
        ));
  }
}

class QuestionCard extends StatelessWidget {
  final Color color;
  final int index;
  final int questionIndex;
  final bool isOptional;
  const QuestionCard(
      {Key? key,
      required this.color,
      this.isOptional = false,
      required this.index,
      required this.questionIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    NewGamePageController controller = Get.find();
    return InkWell(
        onTap: () async => {
              controller.entryController.text = controller.game.value
                      .questions![questionIndex].choices![index].choiceText ??
                  "",
              await showPopup(
                  context: context,
                  child: AnswerPopup(
                    color: color,
                    index: index,
                    questionIndex: questionIndex,
                    onEditingComplete: () => {
                      controller
                          .game
                          .value
                          .questions![questionIndex]
                          .choices![index]
                          .choiceText = controller.entryController.text,
                      controller.entryController.text = ""
                    },
                  ))
            },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.border),
              boxShadow: [CustomBoxShadow()]),
          child: controller.game.value.questions![questionIndex].choices![index]
                      .choiceText ==
                  null
              ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.add, color: AppTheme.white, size: 40),
                  Text(
                    AppLocalizations.of(navigatorKey.currentContext!)!
                        .addAnswer,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: AppTheme.bodyFontsize15,
                        color: AppTheme.white),
                  ),
                  isOptional
                      ? Text(
                          AppLocalizations.of(navigatorKey.currentContext!)!
                              .optional,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: AppTheme.bodyFontsize15,
                              color: AppTheme.white),
                        )
                      : const SizedBox.shrink(),
                ])
              : Stack(
                  children: [
                    controller.game.value.questions![questionIndex]
                            .choices![index].isCorrectAnswer!
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.topRight,
                              child: const Icon(
                                Icons.assignment_turned_in,
                                color: Colors.green,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                    Center(
                      child: Text(
                        controller.game.value.questions![questionIndex]
                                .choices![index].choiceText ??
                            "",
                        maxLines: 5,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppTheme.bodyFontsize15,
                            color: AppTheme.white),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
