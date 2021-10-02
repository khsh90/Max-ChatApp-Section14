import '../widgets/chat/new_messages.dart';

import '../widgets/chat/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat screen'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessages(),
          ],
        ),
      ),
      // StreamBuilder(
      //     //used to fetch the data from firestore as Stream bulider is flutter class
      //     stream: Firestore.instance
      //         .collection('chat/IQD8Vas22WURM65aA685/messages')
      //         .snapshots(),
      //     builder: (context, snapshot) {
      //       final documents = snapshot.data.documents;
      //       //this if used as the snap shot at begining is empty
      //       if (snapshot.connectionState == ConnectionState.waiting)
      //         Center(
      //           child: CircularProgressIndicator(),
      //         );

      //       return ListView.builder(
      //         itemCount: documents.length,
      //         itemBuilder: (context, index) => Container(
      //           padding: EdgeInsets.all(10),
      //           child: Text(documents[index]['text']),
      //         ),
      //       );
      //     }),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Firestore.instance
      //     //     .collection('chat/IQD8Vas22WURM65aA685/messages')
      //     //     .snapshots()
      //     //     .listen((event) {
      //     //   event.documents.forEach((element) {
      //     //     print(element['text']);
      //     //   }
      //     //   );

      //     // });

      //     Firestore.instance
      //         .collection('chat/IQD8Vas22WURM65aA685/messages')
      //         .add({'text': 'this added by clicking on + button'});
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
