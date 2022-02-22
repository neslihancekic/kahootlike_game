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

import '../../main.dart';

class LeaderBoardPage extends StatelessWidget {
  final Game game;
  final User thisUser;
  const LeaderBoardPage({Key? key, required this.game, required this.thisUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    LeaderBoardPageController controller =
        Get.put(LeaderBoardPageController(context, game, thisUser));
    return Scaffold(
        backgroundColor: AppTheme.primary,
        body: SafeArea(
          child: RefreshIndicator(
              onRefresh: () async => {await controller.getLeaderboard()},
              child: CustomScrollView(slivers: [
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 5,
                        ),
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppTheme.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [CustomBoxShadow()]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        controller.leaders[index].user!.first
                                            .nickname!,
                                        style: const TextStyle(
                                            fontSize: AppTheme.body2Fontsize18,
                                            color: AppTheme.primary,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        controller.leaders[index].point != null
                                            ? controller.leaders[index].point
                                                .toString()
                                            : "0",
                                        style: const TextStyle(
                                            fontSize: AppTheme.body2Fontsize18,
                                            color: AppTheme.primary,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                            childCount: controller.leaders.length),
                      )),
                ),
              ])),
        ));
  }
}

class LeaderBoardPageController extends BaseGetxController {
  final UserService _userService = Get.find();
  final GameService _gameService = Get.find();
  final LeaderboardService _leaderboardService = Get.find();

  final game = Game(questions: []).obs;
  final leaders = <LeaderboardModel>[].obs;
  User user;
  LeaderBoardPageController(BuildContext context, g, this.user)
      : super(context) {
    game.value = g;
  }

  Future getLeaderboard() async {
    var leads = await _leaderboardService.getLeaderboard(game.value.id!);
    leaders.value = leads!;
  }

  @override
  void onInit() async {
    super.onInit();
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
