import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahootlike_game/models/user_model.dart';
import 'package:kahootlike_game/services/game_service.dart';
import 'package:kahootlike_game/services/user_service.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/create_new_game/new_game.dart';
import 'package:kahootlike_game/views/generic.dart/actions.dart';
import 'package:kahootlike_game/views/generic.dart/base.dart';
import 'package:kahootlike_game/views/generic.dart/templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kahootlike_game/views/in_game/waiting_room.dart';

import '../main.dart';

class OpenningPage extends StatelessWidget {
  const OpenningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OpenningPageController controller =
        Get.put(OpenningPageController(context));
    final node = FocusScope.of(context);
    return Scaffold(
        body: Stack(
      children: [
        Container(
            color: AppTheme.primary,
            child: SafeArea(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Kahootlike Game',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppTheme.headerFontsize26,
                            color: AppTheme.white),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [CustomBoxShadow()]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: Column(children: [
                            Container(
                              child: CustomEntry(
                                  AppLocalizations.of(
                                          navigatorKey.currentContext!)!
                                      .gamePin,
                                  controller.kahootPinController,
                                  controller.kahootPinFocusNode,
                                  onEditingComplete: () => node.nextFocus(),
                                  maxLength: 8,
                                  fontSize: AppTheme.headerFontsize26,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  autoFocus: false),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: CustomEntry(
                                  AppLocalizations.of(
                                          navigatorKey.currentContext!)!
                                      .nickName,
                                  controller.nickNameController,
                                  controller.nickNameFocusNode,
                                  onEditingComplete: () => node.nextFocus(),
                                  fontSize: AppTheme.headerFontsize26,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  autoFocus: false),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async => {await controller.enterGame()},
                              child: Container(
                                alignment: Alignment.center,
                                height: 58,
                                decoration: BoxDecoration(
                                    color: AppTheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [CustomBoxShadow()]),
                                child: Text(
                                  AppLocalizations.of(
                                          navigatorKey.currentContext!)!
                                      .enter,
                                  style: const TextStyle(
                                      fontSize: AppTheme.body2Fontsize18,
                                      color: AppTheme.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.to(() => const NewGamePage()),
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
                                const Icon(Icons.add, color: AppTheme.primary),
                                const SizedBox(width: 10),
                                Text(
                                  AppLocalizations.of(
                                          navigatorKey.currentContext!)!
                                      .createAGame,
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
                    ],
                  ),
                ),
              ),
            )),
        Obx(() => Visibility(
            visible: controller.isBusy.value, child: BusyPageIndicator()))
      ],
    ));
  }
}

class OpenningPageController extends BaseGetxController {
  final kahootPinController = TextEditingController();
  final kahootPinFocusNode = FocusNode();
  final nickNameController = TextEditingController();
  final nickNameFocusNode = FocusNode();
  final UserService _userService = Get.find();
  final GameService _gameService = Get.find();
  OpenningPageController(BuildContext context) : super(context);

  Future enterGame() async {
    if (isBusy.value) return;
    isBusy.value = true;
    var g =
        await _gameService.getGameByPin(int.parse(kahootPinController.text));
    if (g != null && g.state == 10) {
      var u = await _userService.createUser(User(
          nickname: nickNameController.text,
          pin: int.parse(kahootPinController.text),
          isHost: false));

      var users = await _userService.getUsersInGame(g.id!);

      Get.to(() => WaitingRoomPage(game: g, users: users, thisUser: u!));
    } else {
      await showCustomGeneralDialog(
          context,
          const Icon(
            Icons.error_outline,
            size: 100,
            color: AppTheme.critical,
          ),
          AppLocalizations.of(context)!.gameAlreadyStarted,
          AppLocalizations.of(context)!.done);
    }
    isBusy.value = false;
  }
}
