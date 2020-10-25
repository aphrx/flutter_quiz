import 'package:flutter/material.dart';
import 'package:flutter_quizundefined/index.dart';

class YouAwesomePage extends StatefulWidget {
  static const String routeName = '/youAwesome';

  @override
  _YouAwesomePageState createState() => _YouAwesomePageState();
}

class _YouAwesomePageState extends State<YouAwesomePage> {
  final _youAwesomeBloc = YouAwesomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouAwesome'),
      ),
      body: YouAwesomeScreen(youAwesomeBloc: _youAwesomeBloc),
    );
  }
}
