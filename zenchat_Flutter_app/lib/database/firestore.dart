import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/*

This database stores the posts that the users have published in their app.
It is stored in the collection called 'Posts' in Firebase

Each post contains:
- a message
- email.of users
- timestamp 

*/

class FirestoreDatabase {
  // current logged in users
  User? user = FirebaseAuth.instance.currentUser;

  // get the collection og posts from the firestore
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
    });
  }

  // read posts from database
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();
    return postsStream;
  }
}
