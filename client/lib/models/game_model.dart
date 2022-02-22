import 'package:kahootlike_game/models/choice_model.dart';
import 'package:kahootlike_game/models/question_model.dart';

class Game {
  String? id;
  String? title;
  String? description;
  int? pin;
  int? state;
  List<Question>? questions;

  Game(
      {this.id,
      this.title,
      this.description,
      this.pin,
      this.state,
      this.questions});

  Game.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    pin = json['pin'];
    state = json['state'];
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['pin'] = this.pin;
    data['state'] = this.state;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data.removeWhere((key, value) => key == null || value == null);
    return data;
  }
}
