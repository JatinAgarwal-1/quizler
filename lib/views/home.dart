import 'package:flutter/material.dart';
import 'package:quizler/services/database.dart';
import 'package:quizler/views/play_quiz.dart';
import 'package:quizler/widgets/widgets.dart';

import 'creat_quiz.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DataBaseService dataBaseService = DataBaseService();
  Stream quizStream;

  Widget quizLst() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return QuizTile(
                      quizId:
                          snapshot.data.documents[index].data["quizId"] != null
                              ? snapshot.data.documents[index].data["quizId"]
                              : "hi",
                      title: snapshot.data.documents[index].data["quizTitle"] !=
                              null
                          ? snapshot.data.documents[index].data["quizTitle"]
                          : "hi",
                      des:
                          snapshot.data.documents[index].data["quizDes"] != null
                              ? snapshot.data.documents[index].data["quizDes"]
                              : "hello ",
                      url: snapshot.data.documents[index].data["quizImgUrl"] !=
                              null
                          ? snapshot.data.documents[index].data["quizImgUrl"]
                          : "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
                    );
                  },
                );
        },
      ),
    );
  }

  @override
  void initState() {
    dataBaseService.getQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
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
      body: quizLst(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        hoverColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatQuiz()),
          );
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String url;
  final String title;
  final String des;
  final String quizId;
  QuizTile(
      {@required this.url,
      @required this.des,
      @required this.title,
      @required this.quizId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayQuiz(quizId)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                url,
                width: MediaQuery.of(context).size.width - 48,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    des,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
