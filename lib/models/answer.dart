import 'dart:convert';
import 'dart:core';

import 'package:revisiones_spm/models/audit.dart';

class Answer {
  Answer({
    this.id,
    this.auditId,
    this.questionId,
    this.answer,
    this.comment,
  });

  String id;
  String auditId;
  String questionId;
  String answer;
  String comment;

  //  GETTERS
  String get getId => id;
  String get getAuditId => auditId;
  String get getQuestionId => questionId;
  String get getAnswer => answer;
  String get getComment => comment;

  factory Answer.fromRawJson(String str) => Answer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        auditId: json["audit_id"],
        questionId: json["question_id"],
        answer: json["answer"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "audit_id": auditId,
        "question_id": questionId,
        "answer": answer,
        "comment": comment,
      };
}
