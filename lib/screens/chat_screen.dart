import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: 10,
      itemBuilder: (context, index) => Container(
        child: Text("chat app"),
      ),
    ));
  }
}
