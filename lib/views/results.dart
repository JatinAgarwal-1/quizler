import 'package:flutter/material.dart';
import 'package:quizler/widgets/widgets.dart';

class Result extends StatefulWidget {
  final int total, correct, inCorrect;
  Result(
      {@required this.correct, @required this.inCorrect, @required this.total});
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.correct} / ${widget.total}",
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),
              SizedBox(height: 8),
              Text(
                "You Answered ${widget.correct} "
                "answers correctly ${widget.inCorrect} "
                "answers incorrectly",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black26,
                ),
              ),
              SizedBox(height: 14),
              GestureDetector(
                child: blueButtonS(context, "Go To Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
