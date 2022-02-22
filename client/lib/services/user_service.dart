import 'package:get/get.dart';
import 'package:kahootlike_game/models/user_model.dart';
import 'dart:convert';

import 'package:kahootlike_game/services/service_base.dart';
import 'package:kahootlike_game/utils/constants.dart';

class UserService extends ServiceBase {
  Future<User?> createUser(User user) async {
    try {
      final response = await apiService.post(Constants.serverUrl, '/users',
          body: jsonEncode(user.toJson()));

      var encodedResponse = User.fromJson(jsonDecode(response));
      return encodedResponse;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<List<User>> getUsersInGame(String gameId) async {
    try {
      final response = await apiService.get(
        Constants.serverUrl,
        '/users/inGame/$gameId',
      );
      var encodedResponse = List<User>.empty(growable: true);
      jsonDecode(response).forEach((v) {
        encodedResponse.add(User.fromJson(v));
      });
      return encodedResponse;
    } on Exception catch (e) {
      return [];
    }
  }
}
