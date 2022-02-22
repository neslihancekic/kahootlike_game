import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kahootlike_game/services/service_base.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kahootlike_game/utils/constants.dart';

class UploadService extends ServiceBase {
  Future<String?> postImg(String filePath) async {
    try {
      var dio = Dio();
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: 'profile.jpeg',
          contentType: new MediaType("image", "jpeg"),
        )
      });
      var response;
      try {
        response = await dio.post(
            Uri.http(Constants.serverUrl, "files/upload").toString(),
            data: formData);
      } on DioError catch (e) {
        throw Exception(e.response?.data);
      }
      return response.data;
    } catch (e) {}
  }
}
