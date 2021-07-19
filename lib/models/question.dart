import 'dart:convert';
import 'dart:core';

class Question {
  Question({
    this.id,
    this.question,
    this.checklistId,
  });

  String id;
  String question;
  String checklistId;

  //  GETTERS
  String get getId => id;
  String get getQuestion => question;
  String get getChecklistId => checklistId;

  factory Question.fromRawJson(String str) =>
      Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        question: json["question"],
        checklistId: json["checklist_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "checklist_id": checklistId,
      };
}
