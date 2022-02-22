import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

import 'package:kahootlike_game/services/network/custom_exception.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/generic.dart/actions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApiService {
  Map<String, String> get headers {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future<String> get(String baseUrl, String path,
      {Map<String, dynamic>? parameters}) async {
    var responseJson;
    try {
      final response =
          await http.get(Uri.http(baseUrl, path, parameters), headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on Exception catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<String> post(String baseUrl, String path,
      {Map<String, dynamic>? parameters, String? body}) async {
    var responseJson;
    try {
      final response = await http.post(Uri.http(baseUrl, path, parameters),
          body: body, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<String> patch(String baseUrl, String path,
      {Map<String, dynamic>? parameters, String? body}) async {
    var responseJson;
    try {
      final response = await http.patch(Uri.http(baseUrl, path, parameters),
          body: body, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<String> delete(String baseUrl, String path,
      {Map<String, dynamic>? parameters}) async {
    var responseJson;
    try {
      final response = await http.delete(Uri.http(baseUrl, path, parameters),
          headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<String> _response(http.Response response) async {
    if (response.statusCode >= 400) {
      BuildContext context = Get.context!;
      await showCustomGeneralDialog(
          context,
          const Icon(
            Icons.error_outline,
            size: 100,
            color: AppTheme.critical,
          ),
          response.body,
          AppLocalizations.of(context)!.done);
    }

    return response.body;
  }
}
