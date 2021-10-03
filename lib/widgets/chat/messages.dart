import 'package:firebase_auth/firebase_auth.dart';

import '../chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
            stream: Firestore.instance
                .collection('chats')
                .orderBy('createdAt',
                    descending:
                        true) //in order to git correct order of messages
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = snapshot.data.documents;

              //the future bulider it shall be here but becasue there is
              //stream bulider it should above it , becuase it's not good
              //each timr send a message make check on current user.

              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (context, index) => MessageBubble(
                    chatDocs[index]['text'],
                    chatDocs[index]['userId'] == futureSnapshot.data.uid,
                    key: ValueKey(chatDocs[index].documentID)),
              );
            });
      },
    );
  }
}
