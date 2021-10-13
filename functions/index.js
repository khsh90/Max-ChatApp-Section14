const functions = require("firebase-functions");

  exports.createUser = functions.firestore

  //between {} put any name you want it's just a trigger for firebase
exports.myFunction = functions.firestore
  .document('chat/{message}')
  .onCreate((snapshot, context) => { 

    console.log(snapshot.data()) ;

   });

