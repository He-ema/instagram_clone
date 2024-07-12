import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/constants.dart';
import 'package:instagram_clone/features/add_post_and_reels/data/models/user_model.dart';
import 'package:instagram_clone/features/home/data/models/comment_model.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());

  Future<void> addComment({
    required String comment,
    required String type,
    required String uuid,
  }) async {
    try {
      var uid = const Uuid().v4();
      UserModel user = await getUser();
      await FirebaseFirestore.instance
          .collection(type)
          .doc(uuid)
          .collection(kCommentsCollectionReference)
          .doc(uid)
          .set({
        kComment: comment,
        kUserName: user.userName,
        kUserProfileImage: user.image,
        kCommentId: uid,
      });

      emit(CommentSuccess());
    } catch (e) {
      emit(CommentFailure(errorMessage: e.toString()));
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
}
