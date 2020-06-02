import 'package:flutter/material.dart';

class ShowError extends StatelessWidget {
  ShowError(this.errorMsg);
  final String errorMsg;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(errorMsg),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
