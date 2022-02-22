import 'package:get/get.dart';
import 'package:kahootlike_game/models/game_model.dart';
import 'package:kahootlike_game/models/leaderboard_model.dart';
import 'dart:convert';

import 'package:kahootlike_game/services/service_base.dart';
import 'package:kahootlike_game/utils/constants.dart';

class LeaderboardService extends ServiceBase {
  Future<String?> createLeaderboard(LeaderboardModel leaderboardModel) async {
    try {
      final response = await apiService.post(
          Constants.serverUrl, '/leaderboards',
          body: jsonEncode(leaderboardModel.toJson()));
      return response;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<List<LeaderboardModel>?> getLeaderboard(String gameId) async {
    try {
      final response =
          await apiService.get(Constants.serverUrl, '/leaderboards/$gameId');
      var encodedResponse = List<LeaderboardModel>.empty(growable: true);
      jsonDecode(response).forEach((v) {
        encodedResponse.add(LeaderboardModel.fromJson(v));
      });
      return encodedResponse;
    } on Exception catch (e) {
      return null;
    }
  }

  Future updateLeaderboard(
      String gameId, String userId, LeaderboardModel point) async {
    try {
      final response = await apiService.patch(
          Constants.serverUrl, '/leaderboards/$gameId/$userId',
          body: jsonEncode(point.toJson()));
    } on Exception catch (e) {}
  }
}
