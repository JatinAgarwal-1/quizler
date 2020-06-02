import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizler/services/database.dart';
import 'package:quizler/views/addQuestion.dart';
import 'package:quizler/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreatQuiz extends StatefulWidget {
  @override
  _CreatQuizState createState() => _CreatQuizState();
}

class _CreatQuizState extends State<CreatQuiz> {
  DataBaseService dataBaseService = DataBaseService();
  final _formKey = GlobalKey<FormState>();
  String quizImage;
  String quizTitle;
  String quizDes;
  String quizId;

  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImage,
        "quizTitle": quizTitle,
        "quizDes": quizDes,
      };
      await dataBaseService.addData(quizMap, quizId);
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AddQuestion(quizId: quizId),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Quiz Image Url" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Image Url()",
                      ),
                      onChanged: (val) {
                        quizImage = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Quiz Title" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Title",
                      ),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Quiz Description" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Description",
                      ),
                      onChanged: (val) {
                        quizDes = val;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      child: blueButton(context, "Create Quiz"),
                      onTap: () {
                        createQuizOnline();
                      },
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
