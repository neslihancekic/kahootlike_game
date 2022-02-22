import 'package:kahootlike_game/models/choice_model.dart';

class Question {
  String? id;
  String? gameId;
  String? questionText;
  String? questionPhoto;
  int? questionPoint;
  int? timeLimit;
  bool? isMultiSelect;
  int? type;
  List<Choice>? choices;

  Question(
      {this.id,
      this.gameId,
      this.questionText,
      this.questionPhoto,
      this.questionPoint,
      this.timeLimit,
      this.isMultiSelect,
      this.type,
      this.choices});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    gameId = json['gameId'];
    questionText = json['questionText'];
    questionPhoto = json['questionPhoto'];
    questionPoint = json['questionPoint'];
    timeLimit = json['timeLimit'];
    isMultiSelect = json['isMultiSelect'];
    type = json['type'];
    if (json['choices'] != null) {
      choices = <Choice>[];
      json['choices'].forEach((v) {
        choices!.add(new Choice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['gameId'] = this.gameId;
    data['questionText'] = this.questionText;
    data['questionPhoto'] = this.questionPhoto;
    data['questionPoint'] = this.questionPoint;
    data['timeLimit'] = this.timeLimit;
    data['isMultiSelect'] = this.isMultiSelect;
    data['type'] = this.type;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    data.removeWhere((key, value) => key == null || value == null);
    return data;
  }
}
