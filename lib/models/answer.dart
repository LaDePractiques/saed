import 'dart:convert';
import 'dart:core';

class Answer {
  Answer({
    this.questionId,
    this.question,
    this.answerId,
    this.answer,
    this.comment,
  });

  String questionId;
  String question;
  String answerId;
  String answer;
  String comment;

  //  GETTERS
  String get getId => questionId;
  String get getAuditId => question;
  String get getQuestionId => answerId;
  String get getAnswer => answer;
  String get getComment => comment;

  factory Answer.fromRawJson(String str) => Answer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        questionId: json["question_id"],
        question: json["question"],
        answerId: json["answer_id"],
        answer: json["answer"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question": question,
        "answer_id": answerId,
        "answer": answer,
        "comment": comment,
      };
}

// Summary chart audit
class ChartAudit {
  ChartAudit({
    this.answer,
    this.total,
  });

  String answer;
  String total;

  //  GETTERS
  String get getAnswer => answer;
  String get gettotal => total;

  factory ChartAudit.fromRawJson(String str) =>
      ChartAudit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChartAudit.fromJson(Map<String, dynamic> json) => ChartAudit(
        answer: json["answer"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "total": total,
      };
}
