import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/create_new_game/new_game.dart';
import 'package:kahootlike_game/views/generic.dart/base.dart';
import 'package:kahootlike_game/views/generic.dart/templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

class OpenningPage extends StatelessWidget {
  const OpenningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OpenningPageController controller =
        Get.put(OpenningPageController(context));
    final node = FocusScope.of(context);
    return Scaffold(
        body: Container(
            color: AppTheme.primary,
            child: SafeArea(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
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
                                  textInputAction: TextInputAction.done,
                                  autoFocus: false),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
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
            )));
  }
}

class OpenningPageController extends BaseGetxController {
  final kahootPinController = TextEditingController();
  final kahootPinFocusNode = FocusNode();

  OpenningPageController(BuildContext context) : super(context);
}
