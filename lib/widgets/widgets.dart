import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
//    textAlign: TextAlign.center,
    text: TextSpan(
        style: TextStyle(
          fontSize: 40,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Quiz',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          TextSpan(
            text: 'Ler',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          )
        ]),
  );
}

Widget blueButton(BuildContext context, String label) {
  return Container(
    height: 50,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: Colors.blue,
    ),
    width: double.infinity,
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget blueButtonS(BuildContext context, String label) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width / 2 - 30,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: Colors.blue,
    ),
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
  );
}
