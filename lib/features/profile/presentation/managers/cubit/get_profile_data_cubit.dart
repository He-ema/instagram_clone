import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/constants.dart';
import 'package:meta/meta.dart';

import '../../../../add_post_and_reels/data/models/user_model.dart';
import '../../../../home/data/models/post_model.dart';

part 'get_profile_data_state.dart';

class GetProfileDataCubit extends Cubit<GetProfileDataState> {
  GetProfileDataCubit() : super(GetProfileDataInitial());
  List<PostModel> posts = [];

  Future<void> getProfileData() async {
    emit(GetProfileDataLoading());
    try {
      UserModel userModel = await getUser();
      List<PostModel> posts = await getPosts();
      emit(GetProfileDataSuccess(userModel: userModel, posts: posts));
    } catch (e) {
      emit(GetProfileDataFailure(errorMessage: e.toString()));
    }
  }

  Future<List<PostModel>> getPosts() async {
    CollectionReference chat =
        FirebaseFirestore.instance.collection(kPostsCollectionReference);
    chat
        .orderBy(kDate, descending: true)
        .where(kUserId, isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      posts.clear();
      for (var doc in event.docs) {
        posts.add(PostModel.fromJson(doc));
      }
    });
    return posts;
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
