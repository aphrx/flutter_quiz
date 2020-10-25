import 'package:flutter/material.dart';
import 'package:flutter_quiz/database/db.dart';
import 'package:flutter_quiz/database/question_item.dart';
import 'package:flutter_quiz/database/quiz_item.dart';
import 'package:flutter_quiz/pages/question.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewQuiz extends StatefulWidget{
  final QuizItem quiz;

  ViewQuiz({this.quiz});

  @override
  State<StatefulWidget> createState() => _ViewQuizState(quiz: this.quiz);
}

class _ViewQuizState extends State<ViewQuiz>{

  final QuizItem quiz;

  _ViewQuizState({this.quiz});

  List<QuestionItem> questions  = [];
  List<Widget> get activeWidgets => questions.map((item) => formatQuestions(item)).toList();

  void initState(){
    super.initState();
    fetchQuestions();
  }

  void dispose() {
    super.dispose();
  }

  void _addQuestion(List info, BuildContext c){
    print(info);
    Navigator.pop(context);
    QuestionItem q = QuestionItem(
      questionId: quiz.id,
      question: info[0],
      correctAnswer: info[1],
      wrongAnswerA: info[2],
      wrongAnswerB: info[3],
      wrongAnswerC: info[4] 
    );
    DB.insert(QuestionItem.table, q);
    fetchQuestions();
  }

  void _createDialog(BuildContext context){
    List _questionInfo = ["", "", "", "", ""];
    var question = TextField(
      style: GoogleFonts.montserrat(
        color: Color.fromRGBO(105, 105, 108, 1),
        fontSize: 18,
        fontWeight: FontWeight.normal
      ),
      onChanged: (value) {
        _questionInfo[0] = value;
      }
    );
    var cAnswer = TextField(
      style: GoogleFonts.montserrat(
        color: Color.fromRGBO(105, 105, 108, 1),
        fontSize: 18,
        fontWeight: FontWeight.normal
      ),
      onChanged: (value) {
        _questionInfo[1] = value;
      }
    );
    var wAnswer1 = TextField(
      style: GoogleFonts.montserrat(
        color: Color.fromRGBO(105, 105, 108, 1),
        fontSize: 18,
        fontWeight: FontWeight.normal
      ),
      onChanged: (value) {
        _questionInfo[2] = value;
      }
    );
    var wAnswer2 = TextField(
      style: GoogleFonts.montserrat(
        color: Color.fromRGBO(105, 105, 108, 1),
        fontSize: 18,
        fontWeight: FontWeight.normal
      ),
      onChanged: (value) {
        _questionInfo[3] = value;
      }
    );
    var wAnswer3 = TextField(
      style: GoogleFonts.montserrat(
        color: Color.fromRGBO(105, 105, 108, 1),
        fontSize: 18,
        fontWeight: FontWeight.normal
      ),
      onChanged: (value) {
        _questionInfo[4] = value;
      }
    );
    var btn = FlatButton(
      child: Text(
        'Save', 
        style: GoogleFonts.montserrat(
          color: Color.fromRGBO(59, 57, 60, 1),
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
      onPressed: () => _addQuestion(_questionInfo, context),
    );
    var cancelBtn = FlatButton(
      child: Text(
        'Cancel', 
        style: GoogleFonts.montserrat(
          color: Color.fromRGBO(59, 57, 60, 1),
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
      onPressed: () => Navigator.of(context).pop(false),
    );
    showDialog(
      context: context, 
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6)
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle, 
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 10)
                  )
                ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16),
                  Text("Add Quiz", style: GoogleFonts.montserrat(
                    color: Color.fromRGBO(59, 57, 60, 1),
                    fontSize: 18, 
                    fontWeight: FontWeight.bold
                  )),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        question, cAnswer, wAnswer1, wAnswer2, wAnswer3
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [btn, cancelBtn],
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }

  void fetchQuestions() async{
    List<Map<String, dynamic>> _results = await DB.queryQuestions(QuestionItem.table, quiz);
    questions = _results.map((quiz) => QuestionItem.fromMap(quiz)).toList();
    setState(() {});
  }

  Widget formatQuestions(QuestionItem item){
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
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.question, style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),  
              ],
            ),
          ]
        )
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(quiz.name, style: Theme.of(context).primaryTextTheme.headline1),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () => _createDialog(context))
        ],
      ),
      floatingActionButton: Visibility(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: FloatingActionButton(
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => ViewQuestions(quiz: quiz)
              )
            ),
            child: Icon(Icons.play_arrow, color: Colors.white),
            backgroundColor: Colors.blue[500],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: activeWidgets
      )
    );
  }
}