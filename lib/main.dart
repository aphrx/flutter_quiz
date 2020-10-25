import 'package:flutter/material.dart';
import 'package:flutter_quiz/pages/homepage.dart';
import 'package:flutter_quiz/theme.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: notifier.isDarkTheme ? dark : light,
            home: HomePage(),
          );
        },
      ),
    );
  }
}