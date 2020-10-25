import 'package:flutter/material.dart';
import 'package:flutter_quiz/database/db.dart';
import 'package:flutter_quiz/database/question_item.dart';
import 'package:flutter_quiz/database/quiz_item.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewQuestions extends StatefulWidget{
  final QuizItem quiz;

  ViewQuestions({this.quiz});

  @override
  State<StatefulWidget> createState() => _ViewQuestionsState(quiz: this.quiz);
}

class _ViewQuestionsState extends State<ViewQuestions>{

  final QuizItem quiz;

  int index = 0;
  int score = 0;

  _ViewQuestionsState({this.quiz});

  List<QuestionItem> questions  = [];
  List<Widget> get questionsList => questions.map((item) => formatQuestions(item)).toList();

  void initState(){
    super.initState();
    fetchQuestions();
  }

  void dispose() {
    super.dispose();
  }

  void fetchQuestions() async{
    List<Map<String, dynamic>> _results = await DB.queryQuestions(QuestionItem.table, quiz);
    questions = _results.map((quiz) => QuestionItem.fromMap(quiz)).toList();
    setState(() {});
  }

  Widget formatQuestions(QuestionItem question){
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(question.question, style: Theme.of(context).primaryTextTheme.headline1),
          SizedBox(height: 50),
          Column(children:answerButtons(question)),
          SizedBox(height: 100),
        ],
      )
    );
  }

  Widget answerButton(String s, bool isCorrect){
    void action(){
      if(isCorrect){
        setState(() {
          index += 1;
          score += 1;
        });
      }
      else{
        setState(() {
          index += 1;
        });
      } 
    }

    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        gradient: LinearGradient(colors: [Colors.blue[700], Colors.blue[400]]),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5)
          )
        ]
      ),
      child:
      FlatButton(child:
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(s, style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),  
              ],
            ),
          ]
        )
      ), 
      onPressed: () => action()),
    );
  }

  void correct(){
    setState(() {
      index += 1;
      score += 1;
    });
  }

  void incorrect(){
    setState(() {
      index += 1;
    });
  }

  List<Widget> answerButtons(QuestionItem q){
    List<Widget> buttons = [];
    buttons.add(answerButton(q.correctAnswer, true));
    buttons.add(answerButton(q.wrongAnswerA, false));
    buttons.add(answerButton(q.wrongAnswerB, false));
    buttons.add(answerButton(q.wrongAnswerC, false));
    buttons.shuffle();
    return buttons;
  }

  Widget body(){
    if(questionsList.length == index){
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("You got a score of  " + score.toString() + " / " + index.toString() + " !", style: Theme.of(context).primaryTextTheme.headline1),
            SizedBox(height: 200)
          ],
        )
      );
    } else{
      return questionsList[index];
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(quiz.name, style: Theme.of(context).primaryTextTheme.headline1),
      ),
      body: body()
    );
  }
}