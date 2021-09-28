import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          //used to fetch the data from firestore as Stream bulider is flutter class
          stream: Firestore.instance
              .collection('chat/IQD8Vas22WURM65aA685/messages')
              .snapshots(),
          builder: (context, snapshot) {
            final documents = snapshot.data.documents;
            //this if used as the snap shot at begining is empty
            if (snapshot.connectionState == ConnectionState.waiting)
              Center(
                child: CircularProgressIndicator(),
              );

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(10),
                child: Text(documents[index]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Firestore.instance
          //     .collection('chat/IQD8Vas22WURM65aA685/messages')
          //     .snapshots()
          //     .listen((event) {
          //   event.documents.forEach((element) {
          //     print(element['text']);
          //   }
          //   );

          // });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
