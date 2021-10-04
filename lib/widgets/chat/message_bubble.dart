import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _message;
  final bool _isMe;
  final Key key;
  final String _userName;

  MessageBubble(this._message, this._isMe, this._userName, {this.key});
  @override
  Widget build(BuildContext context) {
    //we used row here in order to control of bo deoration color not take all width
    return Row(
        mainAxisAlignment:
            _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: _isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        !_isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight:
                        _isMe ? Radius.circular(0) : Radius.circular(12))),
            width: 150,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Column(
                crossAxisAlignment:
                    _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    _userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.title.color),
                  ),
                  Text(
                    _message,
                    style: TextStyle(
                        color: _isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.title.color),
                    textAlign: _isMe ? TextAlign.end : TextAlign.start,
                  ),
                ]),
          ),
        ]);
  }
}
