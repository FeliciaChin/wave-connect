import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RatingController {
  String userName = "Anomynous";
  void addRating(int rate, String comment, String date) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        userName = ds.data()!["userName"];
      }).catchError((e) {
        print("error");
      });
    }

    FirebaseFirestore.instance.collection('Rating').add({
      'Name': userName,
      'Rate': rate,
      'Comment': comment,
      'Date': date,
    }).then((value) => print("success"));
  }
}
