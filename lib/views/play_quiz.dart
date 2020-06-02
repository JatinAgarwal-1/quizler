import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizler/model/question_model.dart';
import 'package:quizler/services/database.dart';
import 'package:quizler/views/results.dart';
import 'package:quizler/widgets/quiz_play_widgets.dart';
import 'package:quizler/widgets/widgets.dart';

int _total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz(this.quizId);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  Stream questionStream;
  DataBaseService dataBaseService = DataBaseService();
  QuerySnapshot questionSnapshot;

  QuestionModel getQuestionModelFromSnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = QuestionModel();

    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"]
    ];

    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctAnswer = questionSnapshot.data["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    dataBaseService.getQuestionData(widget.quizId).then((val) {
      setState(() {
        questionStream = val;
      });
    });
    dataBaseService.getQuizQuestion(widget.quizId).then((val) {
      setState(() {
        questionSnapshot = val;
        _total = questionSnapshot.documents.length;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _total = 0;
    _correct = 0;
    _incorrect = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        brightness: Brightness.light,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: StreamBuilder(
          stream: questionStream,
          builder: (context, snapshot) {
            return questionSnapshot == null
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
//                    shrinkWrap: true,
//                    physics: ClampingScrollPhysics(),
                    itemCount: questionSnapshot.documents.length,
                    itemBuilder: (context, index) {
                      return QuizPlayTile(
                        questionModel: getQuestionModelFromSnapshot(
                            questionSnapshot.documents[index]),
                        index: index,
                      );
                    });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Result(
                        total: _total,
                        correct: _correct,
                        inCorrect: _incorrect,
                      )));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
//  QuestionModel questionModel = QuestionModel();
  QuizPlayTile({this.questionModel, this.index});
  final QuestionModel questionModel;
  final int index;
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Q${widget.index + 1} ${widget.questionModel.question}",
            style: TextStyle(color: Colors.black87, fontSize: 18),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                widget.questionModel.answered = true;
                _notAttempted -= 1;
                optionSelected = widget.questionModel.option1;
                if (optionSelected == widget.questionModel.correctAnswer) {
                  _correct += 1;
                  setState(() {});
                } else {
                  _incorrect += 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAns: widget.questionModel.correctAnswer,
              description: widget.questionModel.option1,
              option: "A",
//              optionSelected: widget.questionModel.optionSelected,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                widget.questionModel.answered = true;
                _notAttempted -= 1;
                optionSelected = widget.questionModel.option2;
                if (optionSelected == widget.questionModel.correctAnswer) {
                  _correct += 1;
                  setState(() {});
                } else {
                  _incorrect += 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAns: widget.questionModel.correctAnswer,
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                widget.questionModel.answered = true;
                _notAttempted -= 1;
                optionSelected = widget.questionModel.option3;
                if (optionSelected == widget.questionModel.correctAnswer) {
                  _correct += 1;
                  setState(() {});
                } else {
                  _incorrect += 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAns: widget.questionModel.correctAnswer,
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                widget.questionModel.answered = true;
                _notAttempted -= 1;
                setState(() {
                  optionSelected = widget.questionModel.option4;
                });
                if (optionSelected == widget.questionModel.correctAnswer) {
                  _correct += 1;
                  setState(() {});
                } else {
                  _incorrect += 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAns: widget.questionModel.correctAnswer,
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
