import 'package:kahootlike_game/models/user_model.dart';

class LeaderboardModel {
  String? sId;
  bool? isFinished;
  int? point;
  String? userId;
  String? gameId;
  List<User>? user;

  LeaderboardModel(
      {this.sId,
      this.isFinished,
      this.point,
      this.userId,
      this.gameId,
      this.user});

  LeaderboardModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isFinished = json['isFinished'];
    point = json['point'];
    userId = json['userId'];
    gameId = json['gameId'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isFinished'] = this.isFinished;
    data['point'] = this.point;
    data['userId'] = this.userId;
    data['gameId'] = this.gameId;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    data.removeWhere((key, value) => key == null || value == null);
    return data;
  }
}
