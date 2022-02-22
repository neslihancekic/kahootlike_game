import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kahootlike_game/models/choice_model.dart';
import 'package:kahootlike_game/models/game_model.dart';
import 'package:kahootlike_game/models/question_model.dart';
import 'package:kahootlike_game/models/user_model.dart';
import 'package:kahootlike_game/services/game_service.dart';
import 'package:kahootlike_game/services/upload_service.dart';
import 'package:kahootlike_game/services/user_service.dart';
import 'package:kahootlike_game/utils/constants.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/create_new_game/entry_popup.dart';
import 'package:kahootlike_game/views/create_new_game/new_question.dart';
import 'package:kahootlike_game/views/generic.dart/actions.dart';
import 'package:kahootlike_game/views/generic.dart/base.dart';
import 'package:kahootlike_game/views/generic.dart/templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kahootlike_game/views/in_game/waiting_room.dart';
import 'package:permission_handler/permission_handler.dart';

import '/../main.dart';

class NewGamePage extends StatelessWidget {
  const NewGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewGamePageController controller = Get.put(NewGamePageController(context));
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
                          InkWell(
                            onTap: () async => await controller.createGame(),
                            child: SizedBox(
                              width: 50,
                              child: Text(
                                AppLocalizations.of(
                                        navigatorKey.currentContext!)!
                                    .done,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppTheme.bodyFontsize15,
                                    color: AppTheme.surface3),
                              ),
                            ),
                          ),
                        ]),
                  )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(navigatorKey.currentContext!)!
                            .title,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppTheme.bodyFontsize15,
                            color: AppTheme.surface3),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async => {
                        controller.entryController.text =
                            controller.game.value.title ?? "",
                        await showPopup(
                            context: context,
                            child: EntryPopup(
                                title: AppLocalizations.of(
                                        navigatorKey.currentContext!)!
                                    .title,
                                onEditingComplete: () => {
                                      controller.game.value.title =
                                          controller.entryController.text,
                                      controller.entryController.text = ""
                                    },
                                count: 95))
                      },
                      child: Container(
                        height: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            border: Border.all(color: AppTheme.border),
                            boxShadow: [CustomBoxShadow()]),
                        child: Text(
                          controller.game.value.title ??
                              AppLocalizations.of(navigatorKey.currentContext!)!
                                  .title,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: AppTheme.bodyFontsize15,
                              color: AppTheme.surface3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async => {
                        controller.entryController.text =
                            controller.game.value.description ?? "",
                        await showPopup(
                            context: context,
                            child: EntryPopup(
                                title: AppLocalizations.of(
                                        navigatorKey.currentContext!)!
                                    .description,
                                onEditingComplete: () => {
                                      controller.game.value.description =
                                          controller.entryController.text,
                                      controller.entryController.text = ""
                                    },
                                count: 400))
                      },
                      child: Container(
                        height: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            border: Border.all(color: AppTheme.border),
                            boxShadow: [CustomBoxShadow()]),
                        child: Text(
                          controller.game.value.description ??
                              AppLocalizations.of(navigatorKey.currentContext!)!
                                  .description,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: AppTheme.bodyFontsize15,
                              color: AppTheme.surface3),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
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
                  )),
              const SizedBox(height: 10),
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
                            SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1),
                              delegate: SliverChildBuilderDelegate(
                                  (context, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () => Get.to(() =>
                                            NewQuestionPage(index: index)),
                                        child: Container(
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: AppTheme.white,
                                              border: Border.all(
                                                  color: AppTheme.border),
                                              boxShadow: [CustomBoxShadow()]),
                                          child: Center(
                                            child: Text(
                                              (index + 1).toString(),
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                      AppTheme.headerFontsize26,
                                                  color: AppTheme.surface3),
                                            ),
                                          ),
                                        ),
                                      )),
                                  childCount:
                                      controller.game.value.questions!.length),
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
                      onTap: () {
                        controller.game.value.questions!.add(Question(
                            choices: [Choice(), Choice(), Choice(), Choice()]));
                        Get.to(() => NewQuestionPage(
                            index:
                                controller.game.value.questions!.length - 1));
                      },
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
  final entryController = TextEditingController();
  final entryFocusNode = FocusNode();
  final UserService _userService = Get.find();
  final GameService _gameService = Get.find();
  final UploadService _uploadService = Get.find();

  final game = Game(questions: []).obs;
  var isImageSelected = false.obs;
  var selectedFile = File("").obs;

  NewGamePageController(BuildContext context) : super(context);

  Future createGame() async {
    var g = await _gameService.createGame(game.value);
    var u;
    if (g != null) {
      u = await _userService
          .createUser(User(nickname: "host", pin: g.pin, isHost: true));

      var users = await _userService.getUsersInGame(g.id!);

      Get.back();
      Get.to(() => WaitingRoomPage(game: g, users: users, thisUser: u!));
    }
  }

  Future<String?> uploadGamePhoto() async {
    var permissionSatus = await Permission.camera.request();
    if (permissionSatus != PermissionStatus.granted) {
      return null;
    }
    if (isImageSelected.value) {
      selectedFile = File("").obs;
      isImageSelected.value = false;
      return null;
    }
    final ImagePicker _picker = ImagePicker();

    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedFile.value = File(pickedFile.path);
      isImageSelected.value = true;
    }

    var result = await _uploadService.postImg(selectedFile.value.path);
    return Constants.serverUrl + "files/" + result!;
  }
}
