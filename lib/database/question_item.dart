import 'package:flutter_quiz/database/model.dart';

class QuestionItem extends Model{
  static String table = "questions";

  int id;
  int questionId;
  String question;
  String correctAnswer;
  String wrongAnswerA;
  String wrongAnswerB;
  String wrongAnswerC;

  QuestionItem({ this.id, this.questionId, this.question, this.correctAnswer, this.wrongAnswerA, this.wrongAnswerB, this.wrongAnswerC});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'question': question,
      'questionId': questionId,
      'correctAnswer': correctAnswer,
      'wrongAnswerA': wrongAnswerA,
      'wrongAnswerB': wrongAnswerB,
      'wrongAnswerC': wrongAnswerC
    };

    if (id != null) {
      map['id'] = id;}
    return map;
  }

  static QuestionItem fromMap(Map<String, dynamic> map){
    return QuestionItem(
      id: map['id'],
      questionId: map['questionId'],
      question: map['question'],
      correctAnswer: map['correctAnswer'],
      wrongAnswerA: map['wrongAnswerA'],
      wrongAnswerB: map['wrongAnswerB'],
      wrongAnswerC: map['wrongAnswerC'],
    );
  }

}