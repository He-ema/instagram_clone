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

  Future<void> getProfileData({required String email}) async {
    emit(GetProfileDataLoading());
    try {
      UserModel userModel = await getUser(email: email);
      List<PostModel> posts = await getPosts(email: email);
      emit(GetProfileDataSuccess(userModel: userModel, posts: posts));
    } catch (e) {
      emit(GetProfileDataFailure(errorMessage: e.toString()));
    }
  }

  Future<List<PostModel>> getPosts({required String email}) async {
    CollectionReference chat =
        FirebaseFirestore.instance.collection(kPostsCollectionReference);
    QuerySnapshot querySnapshot =
        await chat.where(kEmail, isEqualTo: email).get();

    posts.clear();
    for (var doc in querySnapshot.docs) {
      posts.add(PostModel.fromJson(doc.data()));
    }

    return posts;
  }

  Future<UserModel> getUser({required String email}) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(kUsersCollectionReference);

    DocumentSnapshot user = await users.doc(email).get();
    UserModel userModel =
        UserModel.fromJson(user.data() as Map<String, dynamic>);
    return userModel;
  }
}
