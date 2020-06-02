import 'package:flutter/material.dart';
import 'package:quizler/helper/constant.dart';
import 'package:quizler/views/home.dart';
import 'package:quizler/views/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _userLoggedIn = false;

  checkUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInDetail().then((value) {
      setState(() {
        _userLoggedIn = value;
      });
    });
  }

  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (_userLoggedIn ?? false) ? Home() : SignIn(),
    );
  }
}
