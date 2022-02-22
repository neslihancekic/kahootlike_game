import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahootlike_game/models/game_model.dart';
import 'package:kahootlike_game/models/leaderboard_model.dart';
import 'package:kahootlike_game/models/user_model.dart';
import 'package:kahootlike_game/services/game_service.dart';
import 'package:kahootlike_game/services/leaderboard_service.dart';
import 'package:kahootlike_game/services/user_service.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/create_new_game/new_game.dart';
import 'package:kahootlike_game/views/generic.dart/base.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kahootlike_game/views/generic.dart/templates.dart';
import 'package:kahootlike_game/views/in_game/game.dart';
import 'package:kahootlike_game/views/in_game/leaderboard.dart';

import '../../main.dart';

class WaitingRoomPage extends StatelessWidget {
  final Game game;
  final List<User> users;
  final User thisUser;
  const WaitingRoomPage(
      {Key? key,
      required this.game,
      required this.users,
      required this.thisUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WaitingRoomPageController controller =
        Get.put(WaitingRoomPageController(context, game, users, thisUser));
    return Scaffold(
        backgroundColor: AppTheme.primary,
        body: Stack(
          children: [
            RefreshIndicator(
                onRefresh: () async => {await controller.getUsersInGame()},
                child: CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                        color: AppTheme.primary,
                        child: SafeArea(
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppTheme.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [CustomBoxShadow()]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'PIN: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: AppTheme.headerFontsize26,
                                            color: AppTheme.primary),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        game.pin.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: AppTheme.headerFontsize26,
                                            color: AppTheme.primary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
                  SliverToBoxAdapter(
                      child: Column(
                    children: [
                      Text(
                        game.title ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppTheme.headerFontsize26,
                            color: AppTheme.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        game.description ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppTheme.bodyFontsize15,
                            color: AppTheme.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    sliver: Obx(() => SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [CustomBoxShadow()]),
                                    child: Text(
                                      controller.users[index].nickname!,
                                      style: const TextStyle(
                                          fontSize: AppTheme.body2Fontsize18,
                                          color: AppTheme.primary,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                              childCount: controller.users.length),
                        )),
                  ),
                ])),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: thisUser.isHost!
                    ? InkWell(
                        onTap: () async => {
                          await controller.startGame(),
                          await controller.createLeaderboard(),
                          if (thisUser.isHost!)
                            {
                              Get.back(),
                              Get.to(() => LeaderBoardPage(
                                  game: game, thisUser: thisUser))
                            }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 58,
                            decoration: BoxDecoration(
                                color: AppTheme.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [CustomBoxShadow()]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.play_arrow,
                                    color: AppTheme.primary),
                                const SizedBox(width: 10),
                                Text(
                                  AppLocalizations.of(
                                          navigatorKey.currentContext!)!
                                      .startGame,
                                  style: const TextStyle(
                                      fontSize: AppTheme.body2Fontsize18,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.play_for_work_rounded,
                                color: AppTheme.white),
                            const SizedBox(width: 10),
                            Text(
                              AppLocalizations.of(navigatorKey.currentContext!)!
                                  .waitingForPlayers,
                              style: const TextStyle(
                                  fontSize: AppTheme.body2Fontsize18,
                                  color: AppTheme.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
              ),
            )
          ],
        ));
  }
}

class WaitingRoomPageController extends BaseGetxController {
  final UserService _userService = Get.find();
  final GameService _gameService = Get.find();
  final LeaderboardService _leaderboardService = Get.find();

  final game = Game(questions: []).obs;
  final users = <User>[].obs;
  final User user;
  Timer? timer;
  WaitingRoomPageController(BuildContext context, g, u, this.user)
      : super(context) {
    game.value = g;
    users.value = u;
    if (!user.isHost!) {
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
        await getGameState();
      });
    }
  }

  Future createLeaderboard() async {
    await _leaderboardService
        .createLeaderboard(LeaderboardModel(gameId: game.value.id!));
  }

  Future getUsersInGame() async {
    users.value = await _userService.getUsersInGame(game.value.id!);
  }

  Future startGame() async {
    var state = await _gameService.startGame(game.value.id!);
  }

  Future getGameState() async {
    var state = await _gameService.getGameState(game.value.id!);
    if (state == 20) {
      Get.back();
      Get.to(() => GamePage(game: game.value, user: user));
      timer?.cancel();
    }
  }
}

class UserCard extends StatelessWidget {
  final String nickname;
  const UserCard({Key? key, required this.nickname}) : super(key: key);
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
              nickname,
              maxLines: 2,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: AppTheme.bodyFontsize15,
                  color: AppTheme.surface3),
            )));
  }
}
