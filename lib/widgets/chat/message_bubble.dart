import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _message;

  MessageBubble(this._message);
  @override
  Widget build(BuildContext context) {
    //we used row here in order to control of bo deoration color not take all width
    return Row(children: [
      Container(
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(15)),
        width: 150,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Text(
          _message,
          style:
              TextStyle(color: Theme.of(context).accentTextTheme.title.color),
        ),
      ),
    ]);
  }
}
