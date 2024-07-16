import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/constants.dart';
import 'package:instagram_clone/core/utils/common_methods/pick_image.dart';
import 'package:instagram_clone/features/add_post_and_reels/data/models/user_model.dart';

class UploadStory {
  Future<bool> uploadStory() async {
    try {
      File? image = await uploadImage('Gallery');
      if (image != null) {
        String url = await uploadImageToFirebase(
            image: image, email: DateTime.now().toString());
        FirebaseFirestore.instance
            .collection(kStoriesCollectionReference)
            .doc(FirebaseAuth.instance.currentUser!.email)
            .get()
            .then((value) async {
          if (value.exists) {
            await FirebaseFirestore.instance
                .collection(kStoriesCollectionReference)
                .doc(FirebaseAuth.instance.currentUser!.email)
                .update({
              kStories: FieldValue.arrayUnion([url])
            });
          } else {
            UserModel user = await getUser();
            await FirebaseFirestore.instance
                .collection(kStoriesCollectionReference)
                .doc(FirebaseAuth.instance.currentUser!.email)
                .set({
              kUserName: user.userName,
              kImage: user.image,
              kStories: [
                url,
              ],
              kEmail: FirebaseAuth.instance.currentUser!.email!,
            });
          }
        });
      }

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<String> uploadImageToFirebase(
      {required File image, required String email}) async {
    final ref = FirebaseStorage.instance.ref().child(email);
    await ref.putFile(image);
    final url = await ref.getDownloadURL();
    return url;
  }

  Future<UserModel> getUser() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(kUsersCollectionReference);

    DocumentSnapshot user =
        await users.doc(FirebaseAuth.instance.currentUser!.email).get();
    UserModel userModel =
        UserModel.fromJson(user.data() as Map<String, dynamic>);
    return userModel;
  }
}
