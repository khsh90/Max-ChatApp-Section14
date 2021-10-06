import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _message;
  final bool _isMe;
  final Key key;
  final String _userName;
  final String _imageFile;

  MessageBubble(this._message, this._isMe, this._userName, this._imageFile,
      {this.key});
  @override
  Widget build(BuildContext context) {
    //we used row here in order to control of bo deoration color not take all width
    return Stack(
      children: [
        Row(
            mainAxisAlignment:
                _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: _isMe
                        ? Theme.of(context).accentColor
                        : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft:
                            !_isMe ? Radius.circular(0) : Radius.circular(12),
                        bottomRight:
                            _isMe ? Radius.circular(0) : Radius.circular(12))),
                width: 150,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                    crossAxisAlignment: _isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isMe
                                ? Theme.of(context).accentTextTheme.title.color
                                : Colors.black),
                      ),
                      Text(
                        _message,
                        style: TextStyle(
                            color: _isMe
                                ? Theme.of(context).accentTextTheme.title.color
                                : Colors.black),
                        textAlign: _isMe ? TextAlign.end : TextAlign.start,
                      ),
                    ]),
              ),
            ]),
        //we put the circullar avatar in below to be appear in front of messages
        Positioned(
          top: 0,
          right: _isMe ? 140 : null,
          left: _isMe ? null : 140,
          child: CircleAvatar(
            backgroundImage: NetworkImage(_imageFile),
          ),
        ),
      ],
      overflow: Overflow.visible, //in order to use top with no problem
    );
  }
}
