import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  primaryColor: Color.fromRGBO(246, 248, 250, 1),
  accentColor: Color.fromRGBO(50, 50, 50, 1),
  primaryTextTheme: TextTheme(
    // Section Headings
    headline1: GoogleFonts.montserrat(
      color: Color.fromRGBO(59, 57, 60, 1),
      fontSize: 22,
      fontWeight: FontWeight.bold
    ),

    // Body Text
    bodyText1: GoogleFonts.montserrat(
      color: Color.fromRGBO(105, 105, 108, 1),
      fontSize: 16
    )
  )
);

ThemeData dark = ThemeData(
  primaryColor: Color.fromRGBO(31, 31, 31, 1),
  accentColor: Color.fromRGBO(200, 200, 200, 1),
  primaryTextTheme: TextTheme(
    // Section Headings
    headline1: GoogleFonts.montserrat(
      color: Color.fromRGBO(250, 250, 250, 1),
      fontSize: 22,
      fontWeight: FontWeight.bold
    ),

    // Body Text
    bodyText1: GoogleFonts.montserrat(
      color: Color.fromRGBO(200, 200, 200, 1),
      fontSize: 16
    )
  )
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _isDarkTheme;

  bool get isDarkTheme => _isDarkTheme;

  ThemeNotifier() {
    _isDarkTheme = false;
    _getThemePref();
  }

  void _getThemePref() async{
    await _initPrefs();
    _isDarkTheme = _prefs.getBool(key) ?? false;
    notifyListeners();
  }

  void _setThemePrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _isDarkTheme);
  }

  void _initPrefs() async {
    if(_prefs == null){
      _prefs = await SharedPreferences.getInstance();
    }
  }

  void toggleTheme(){
    _isDarkTheme = !_isDarkTheme;
    _setThemePrefs();
    notifyListeners();
  }
}