import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:get/get.dart';

abstract class BaseGetxController extends GetxController {
  final BuildContext context;
  BaseGetxController(this.context);
  var isBusy = false.obs;
  var isInitialized = false.obs;
}
