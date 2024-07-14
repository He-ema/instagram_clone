import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/constants.dart';

class Like {
  Future<String> like({
    required List like,
    required String postId,
    required String type,
    required String uid,
  }) async {
    String result = 'error';
    try {
      if (like.contains(uid)) {
        FirebaseFirestore.instance.collection(type).doc(postId).update({
          kLikes: FieldValue.arrayRemove([uid]),
        });
      } else {
        FirebaseFirestore.instance.collection(type).doc(postId).update({
          kLikes: FieldValue.arrayUnion([uid]),
        });
      }
      result = 'success';
    } catch (e) {
      result = e.toString();
    }

    return result;
  }
}
