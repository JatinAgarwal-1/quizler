import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  Future<void> addData(Map quizData, String quizId) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuizData() async {
    return Firestore.instance.collection("Quiz").snapshots();
  }

  getQuizQuestion(String quizId) async {
    return await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .getDocuments();
  }

  getQuestionData(String quizId) async {
    return Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .snapshots();
  }
}
