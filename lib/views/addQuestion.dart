import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizler/services/database.dart';
import 'package:quizler/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion({@required this.quizId});

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  DataBaseService dataBaseService = DataBaseService();

  uploadQuestionData() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionData = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };
      await dataBaseService
          .addQuestionData(questionData, widget.quizId)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

//  @override
//  void didChangeMetrics() {
//    final renderObject = context.findRenderObject();
//    final renderBox = renderObject as RenderBox;
//    final offset = renderBox.localToGlobal(Offset.zero);
//    final widgetRect =
//        Rect.fromLTWH(offset.dx, offset.dy, renderBox.width, renderBox.height);
//
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        centerTitle: true,
//        actionsIconTheme: , TODO
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 1,
          opacity: 5,
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Question" : null,
                      decoration: InputDecoration(
                        hintText: "Question",
                      ),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Option1" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Option1 (Correct Answer)",
                      ),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Option2" : null,
                      decoration: InputDecoration(
                        hintText: "Option2",
                      ),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Option3" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Option3",
                      ),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Option4" : null,
                      decoration: InputDecoration(
                        hintText: "Option4",
                      ),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          child: blueButtonS(context, "Submit"),
                          onTap: () {
                            uploadQuestionData();
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          child: blueButtonS(context, "Add Question"),
                          onTap: () {
                            uploadQuestionData();
                          },
                        ),
                      ],
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
