import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _textMsg = '';
  final _textController = TextEditingController();

  void sendMsg() {
    FocusScope.of(context).unfocus();
    Firestore.instance.collection('chats').add({
      'text': _textMsg,
      'createdAt': Timestamp
          .now() //time stap is a fire store class ,used also to get organized messages
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'Send a Message....'),
            onChanged: (value) {
              setState(() {
                _textMsg = value;
              });
            },
          )),
          IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.send,
              ),
              onPressed: _textMsg.trim().isEmpty ? null : sendMsg)
        ],
      ),
    );
  }
}
