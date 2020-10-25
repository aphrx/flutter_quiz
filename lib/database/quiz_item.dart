import 'package:flutter_quiz/database/model.dart';

class QuizItem extends Model{
  static String table = "quizzes";


  int id;
  String name;
  int duration;
  int questionNo;

  QuizItem({ this.id, this.name, this.duration, this.questionNo});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'duration': duration,
      'questionNo': questionNo
    };

    if (id != null) {
      map['id'] = id;}
    return map;
  }

  static QuizItem fromMap(Map<String, dynamic> map){
    return QuizItem(
      id: map['id'],
      name: map['name'],
      duration: map['duration'],
      questionNo: map['questionNo']
    );
  }

}