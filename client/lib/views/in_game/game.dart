import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahootlike_game/models/game_model.dart';
import 'package:kahootlike_game/models/leaderboard_model.dart';
import 'package:kahootlike_game/models/user_model.dart';
import 'package:kahootlike_game/services/game_service.dart';
import 'package:kahootlike_game/services/leaderboard_service.dart';
import 'package:kahootlike_game/services/upload_service.dart';
import 'package:kahootlike_game/services/user_service.dart';
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
import 'package:kahootlike_game/views/in_game/leaderboard.dart';

import '/../main.dart';

class GamePage extends StatelessWidget {
  final Game game;
  final User user;
  const GamePage({Key? key, required this.game, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GamePageController controller =
        Get.put(GamePageController(context, game, user));
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
                              ])),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () async => {},
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
                              children: [
                                Icon(Icons.timelapse, color: AppTheme.white),
                                SizedBox(width: 5),
                                Obx(() => Text(
                                      controller.time.value.toString() + " sn",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: AppTheme.bodyFontsize15,
                                          color: AppTheme.white),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () async => {},
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            border: Border.all(color: AppTheme.border),
                            boxShadow: [CustomBoxShadow()]),
                        child: Obx(() => Text(
                              controller
                                      .game
                                      .value
                                      .questions![
                                          controller.questionIndex.value]
                                      .questionText ??
                                  "",
                              maxLines: 2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppTheme.bodyFontsize15,
                                  color: AppTheme.surface3),
                            )),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(() => GridView.count(
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
                                questionIndex: controller.questionIndex.value,
                              ),
                              QuestionCard(
                                color: AppTheme.blue,
                                index: 1,
                                questionIndex: controller.questionIndex.value,
                              ),
                              QuestionCard(
                                color: AppTheme.yellow,
                                isOptional: true,
                                index: 2,
                                questionIndex: controller.questionIndex.value,
                              ),
                              QuestionCard(
                                color: AppTheme.success,
                                isOptional: true,
                                index: 3,
                                questionIndex: controller.questionIndex.value,
                              ),
                            ])),
                    const SizedBox(height: 5),
                  ],
                ),
              )),
              Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border.all(color: AppTheme.border),
                      boxShadow: [CustomBoxShadow()]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(navigatorKey.currentContext!)!
                                  .question +
                              " " +
                              (controller.questionIndex.value + 1).toString(),
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: AppTheme.headerFontsize26,
                              color: AppTheme.blue),
                        ),
                        Obx(() => controller.isAnswered.value
                            ? Text(
                                controller.isCorrect.value ? "True" : "False",
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppTheme.headerFontsize26,
                                  color: controller.isCorrect.value
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              )
                            : SizedBox.shrink()),
                      ],
                    ),
                  ))
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
    GamePageController controller = Get.find();
    return InkWell(
        onTap: () => {controller.answerQuestion(index)},
        child: Obx(() => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: !controller.isAnswered.value
                      ? color
                      : controller.game.value.questions![questionIndex]
                              .choices![index].isCorrectAnswer!
                          ? Colors.green
                          : Colors.red,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.border),
                  boxShadow: [CustomBoxShadow()]),
              child: controller.game.value.questions![questionIndex]
                          .choices![index].choiceText ==
                      null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          const Icon(Icons.add,
                              color: AppTheme.white, size: 40),
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
                                  AppLocalizations.of(
                                          navigatorKey.currentContext!)!
                                      .optional,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: AppTheme.bodyFontsize15,
                                      color: AppTheme.white),
                                )
                              : const SizedBox.shrink(),
                        ])
                  : Center(
                      child: Obx(() => Text(
                            controller.game.value.questions![questionIndex]
                                    .choices![index].choiceText ??
                                "",
                            maxLines: 5,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: AppTheme.bodyFontsize15,
                                color: AppTheme.white),
                          )),
                    ),
            )));
  }
}

class GamePageController extends BaseGetxController {
  final UserService _userService = Get.find();
  final GameService _gameService = Get.find();
  final LeaderboardService _leaderboardService = Get.find();

  final game = Game(questions: []).obs;
  User user;
  final questionIndex = 0.obs;
  final point = 0.obs;
  final isAnswered = false.obs;
  final isCorrect = false.obs;
  Timer? timer;
  final time = 0.obs;
  GamePageController(BuildContext context, g, this.user) : super(context) {
    game.value = g;
    startTimer();
  }

  startTimer() {
    time.value = game.value.questions![questionIndex.value].timeLimit!;
    timer = Timer.periodic(Duration(seconds: 1), (t) async {
      time.value = time.value - 1;
      if (time.value == 0) {
        t.cancel();
        if (questionIndex.value == game.value.questions!.length - 1) {
          await _leaderboardService.updateLeaderboard(
              game.value.id!, user.id!, LeaderboardModel(point: point.value));
          Get.to(() => LeaderBoardPage(game: game.value, thisUser: user));
          return;
        }
        questionIndex.value = questionIndex.value + 1;
        startTimer();
      }
    });
  }

  Future answerQuestion(int choiceIndex) async {
    isAnswered.value = true;
    timer?.cancel();
    if (game.value.questions![questionIndex.value].choices![choiceIndex]
        .isCorrectAnswer!) {
      isCorrect.value = true;
      point.value = point.value +
          game.value.questions![questionIndex.value].questionPoint!;
    }
    await Future.delayed(Duration(seconds: 3));
    if (questionIndex.value == game.value.questions!.length - 1) {
      await _leaderboardService.updateLeaderboard(
          game.value.id!, user.id!, LeaderboardModel(point: point.value));
      Get.to(() => LeaderBoardPage(game: game.value, thisUser: user));
    } else {
      questionIndex.value = questionIndex.value + 1;
      isAnswered.value = false;
      isCorrect.value = false;
      startTimer();
    }
  }
}
