import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../../../../constants.dart';
import '../../../data/models/user_model.dart';

part 'add_reel_state.dart';

class AddReelCubit extends Cubit<AddReelState> {
  AddReelCubit() : super(AddReelInitial());

  Future<void> createReel({
    required File reelVideo,
    required String caption,
  }) async {
    emit(AddReelLoading());
    try {
      var uid = const Uuid().v4();
      String videoURL = await uploadVideoToFirebase(video: reelVideo, id: uid);
      DateTime date = DateTime.now();
      UserModel userModel = await getUser();
      CollectionReference posts =
          FirebaseFirestore.instance.collection(kReelsCollectionReference);
      await posts.doc(uid).set({
        kReelVideo: videoURL,
        kCaption: caption,
        kEmail: userModel.email,
        kUserName: userModel.userName,
        kUserId: FirebaseAuth.instance.currentUser!.uid,
        kUserProfileImage: userModel.image,
        kDate: date,
        kPostId: uid,
        kLikes: [],
      });
      emit(AddReelSuccess());
    } catch (e) {
      emit(AddReelFailure(errorMessage: e.toString()));
    }
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

  Future<String> uploadVideoToFirebase(
      {required File video, required String id}) async {
    final ref = FirebaseStorage.instance.ref().child(id);
    await ref.putFile(video);
    final url = await ref.getDownloadURL();
    return url;
  }
}
