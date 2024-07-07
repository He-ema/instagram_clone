import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/constants.dart';
import 'package:instagram_clone/features/add_post_and_reels/data/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());

  Future<void> createPost({
    required File postImage,
    required String caption,
    required String location,
  }) async {
    emit(AddPostLoading());
    var uid = const Uuid().v4();
    String image = await uploadImageToFirebase(image: postImage, id: uid);
    DateTime date = DateTime.now();
    UserModel userModel = await getUser();
    CollectionReference posts =
        FirebaseFirestore.instance.collection(kPostsCollectionReference);
    posts.doc(uid).set({
      kImage: image,
      kCaption: caption,
      kLocation: location,
      kEmail: userModel.email,
      kUserName: userModel.userName,
      kUserId: FirebaseAuth.instance.currentUser!.uid,
      kUserProfileImage: userModel.image,
      kDate: date,
      kPostId: uid,
      kLikes: [],
    });
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

  Future<String> uploadImageToFirebase(
      {required File image, required String id}) async {
    final ref = FirebaseStorage.instance.ref().child(id);
    await ref.putFile(image);
    final url = await ref.getDownloadURL();
    return url;
  }
}
