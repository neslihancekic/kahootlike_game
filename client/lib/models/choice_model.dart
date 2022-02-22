class Choice {
  String? id;
  String? questionId;
  String? choiceText;
  bool? isCorrectAnswer;

  Choice(
      {this.id,
      this.questionId,
      this.choiceText,
      this.isCorrectAnswer = false});

  Choice.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    questionId = json['questionId'];
    choiceText = json['choiceText'];
    isCorrectAnswer = json['isCorrectAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['questionId'] = this.questionId;
    data['choiceText'] = this.choiceText;
    data['isCorrectAnswer'] = this.isCorrectAnswer;
    data.removeWhere((key, value) => key == null || value == null);
    return data;
  }
}
