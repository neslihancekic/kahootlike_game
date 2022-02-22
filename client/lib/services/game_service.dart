import 'package:get/get.dart';
import 'package:kahootlike_game/models/game_model.dart';
import 'dart:convert';

import 'package:kahootlike_game/services/service_base.dart';
import 'package:kahootlike_game/utils/constants.dart';

class GameService extends ServiceBase {
  Future<Game?> createGame(Game game) async {
    try {
      final response = await apiService.post(Constants.serverUrl, '/games',
          body: jsonEncode(game.toJson()));

      var encodedResponse = Game.fromJson(jsonDecode(response));
      return encodedResponse;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<Game?> getGame(String id) async {
    try {
      final response = await apiService.get(Constants.serverUrl, '/games/$id');
      var encodedResponse = Game.fromJson(jsonDecode(response));
      return encodedResponse;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<Game?> getGameByPin(int pin) async {
    try {
      final response =
          await apiService.get(Constants.serverUrl, '/games/pin/$pin');
      var encodedResponse = Game.fromJson(jsonDecode(response));
      return encodedResponse;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<int?> getGameState(String id) async {
    try {
      final response =
          await apiService.get(Constants.serverUrl, '/games/state/$id');

      return int.parse(response);
    } on Exception catch (e) {
      return null;
    }
  }

  Future<Game?> startGame(String id) async {
    try {
      final response =
          await apiService.patch(Constants.serverUrl, '/games/start/$id');
      var encodedResponse = Game.fromJson(jsonDecode(response));
      return encodedResponse;
    } on Exception catch (e) {
      return null;
    }
  }
}
