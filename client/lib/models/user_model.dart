class User {
  String? id;
  String? nickname;
  String? playingGameId;
  int? pin;
  bool? isHost;

  User({this.id, this.nickname, this.playingGameId, this.pin, this.isHost});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nickname = json['nickname'];
    playingGameId = json['playingGameId'];
    pin = json['pin'];
    isHost = json['isHost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['nickname'] = this.nickname;
    data['playingGameId'] = this.playingGameId;
    data['pin'] = this.pin;
    data['isHost'] = this.isHost;
    data.removeWhere((key, value) => key == null || value == null);
    return data;
  }
}
