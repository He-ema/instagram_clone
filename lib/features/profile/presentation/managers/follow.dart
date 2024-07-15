import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/constants.dart';

class Follow {
  Future<String> follow({required String email}) async {
    String result = 'error';

    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection(kUsersCollectionReference)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    List follow = (snap.data()! as dynamic)[kFollowing];

    try {
      if (follow.contains(email)) {
        await FirebaseFirestore.instance
            .collection(kUsersCollectionReference)
            .doc(FirebaseAuth.instance.currentUser!.email)
            .update({
          kFollowing: FieldValue.arrayRemove([email]),
        });
        await FirebaseFirestore.instance
            .collection(kUsersCollectionReference)
            .doc(email)
            .update({
          kFollowers: FieldValue.arrayRemove(
              [FirebaseAuth.instance.currentUser!.email]),
        });
      } else {
        FirebaseFirestore.instance
            .collection(kUsersCollectionReference)
            .doc(FirebaseAuth.instance.currentUser!.email)
            .update({
          kFollowing: FieldValue.arrayUnion([email]),
        });
        FirebaseFirestore.instance
            .collection(kUsersCollectionReference)
            .doc(email)
            .update({
          kFollowers:
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.email]),
        });
      }
      result = 'success';
    } catch (e) {
      result = e.toString();
    }

    return result;
  }
}
