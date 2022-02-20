import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/generic.dart/base.dart';
import 'package:kahootlike_game/views/generic.dart/templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/../main.dart';

class NewQuestionPage extends StatelessWidget {
  const NewQuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewQuestionPageController controller =
        Get.put(NewQuestionPageController(context));
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
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
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
                const SizedBox(height: 15),
                CustomEntry(
                    AppLocalizations.of(navigatorKey.currentContext!)!.question,
                    controller.questionController,
                    controller.questionFocusNode,
                    onEditingComplete: () => node.nextFocus(),
                    maxLength: 75,
                    fontSize: AppTheme.headerFontsize26,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    autoFocus: false),
                const SizedBox(height: 15),
                GridView.count(
                    primary: false,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 1.5,
                    children: const <Widget>[
                      QuestionCard(color: AppTheme.red),
                      QuestionCard(color: AppTheme.blue),
                      QuestionCard(color: AppTheme.yellow, isOptional: true),
                      QuestionCard(color: AppTheme.success, isOptional: true),
                    ]),
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

class QuestionCard extends StatelessWidget {
  final Color color;
  final bool isOptional;
  const QuestionCard({Key? key, required this.color, this.isOptional = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.border),
            boxShadow: [CustomBoxShadow()]),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.add, color: AppTheme.white, size: 40),
          Text(
            AppLocalizations.of(navigatorKey.currentContext!)!.addAnswer,
            maxLines: 2,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: AppTheme.bodyFontsize15,
                color: AppTheme.white),
          ),
          isOptional
              ? Text(
                  AppLocalizations.of(navigatorKey.currentContext!)!.optional,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: AppTheme.bodyFontsize15,
                      color: AppTheme.white),
                )
              : const SizedBox.shrink(),
        ]));
  }
}

class NewQuestionPageController extends BaseGetxController {
  final questionController = TextEditingController();
  final questionFocusNode = FocusNode();
  NewQuestionPageController(BuildContext context) : super(context);
}
