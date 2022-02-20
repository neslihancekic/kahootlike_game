import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/create_new_game/new_question.dart';
import 'package:kahootlike_game/views/generic.dart/base.dart';
import 'package:kahootlike_game/views/generic.dart/templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/../main.dart';

class NewGamePage extends StatelessWidget {
  const NewGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewGamePageController controller = Get.put(NewGamePageController(context));
    final node = FocusScope.of(context);
    return Scaffold(
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
                      SizedBox(
                        width: 50,
                        child: Text(
                          AppLocalizations.of(navigatorKey.currentContext!)!
                              .done,
                          maxLines: 2,
                          style: const TextStyle(
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
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              AppLocalizations.of(navigatorKey.currentContext!)!
                                  .addCoverPhoto,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppTheme.body2Fontsize18,
                                  color: AppTheme.surface3),
                            ),
                          ])),
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(navigatorKey.currentContext!)!.title,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: AppTheme.bodyFontsize15,
                        color: AppTheme.surface3),
                  ),
                ),
                const SizedBox(height: 15),
                CustomEntry(
                    AppLocalizations.of(navigatorKey.currentContext!)!.title,
                    controller.titleController,
                    controller.titleFocusNode,
                    onEditingComplete: () => node.nextFocus(),
                    maxLength: 75,
                    fontSize: AppTheme.headerFontsize26,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    autoFocus: false),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(navigatorKey.currentContext!)!
                        .description,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: AppTheme.bodyFontsize15,
                        color: AppTheme.surface3),
                  ),
                ),
                const SizedBox(height: 15),
                CustomEntry(
                    AppLocalizations.of(navigatorKey.currentContext!)!
                        .description,
                    controller.descController,
                    controller.descFocusNode,
                    onEditingComplete: () => node.nextFocus(),
                    maxLength: 200,
                    fontSize: AppTheme.headerFontsize26,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    autoFocus: false),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(navigatorKey.currentContext!)!
                        .questions,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: AppTheme.bodyFontsize15,
                        color: AppTheme.surface3),
                  ),
                ),
              ],
            ),
          )),
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: AppTheme.white,
                border: Border.all(color: AppTheme.border),
                boxShadow: [CustomBoxShadow()]),
            child: Row(
              children: [
                Expanded(
                  child: CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverToBoxAdapter(
                              child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                                color: AppTheme.white,
                                border: Border.all(color: AppTheme.border),
                                boxShadow: [CustomBoxShadow()]),
                          )),
                        ),
                      ]),
                ),
                Container(
                  width: 1,
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border.all(color: AppTheme.border),
                      boxShadow: [CustomBoxShadow()]),
                ),
                InkWell(
                  onTap: () => Get.to(() => const NewQuestionPage()),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 58,
                      decoration: BoxDecoration(
                          color: AppTheme.blue,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [CustomBoxShadow()]),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          AppLocalizations.of(navigatorKey.currentContext!)!
                              .addQuestion,
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
            ),
          )
        ],
      )),
    ));
  }
}

class NewGamePageController extends BaseGetxController {
  final titleController = TextEditingController();
  final titleFocusNode = FocusNode();
  final descController = TextEditingController();
  final descFocusNode = FocusNode();
  NewGamePageController(BuildContext context) : super(context);
}
