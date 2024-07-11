import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/constants.dart';
import 'package:instagram_clone/features/home/data/models/post_model.dart';
import 'package:meta/meta.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial());

  Future<void> getPosts() async {
    emit(ExploreLoading());
    try {
      CollectionReference postsCollection =
          FirebaseFirestore.instance.collection(kPostsCollectionReference);
      QuerySnapshot postsSnapshot = await postsCollection.get();
      List<PostModel> posts = postsSnapshot.docs
          .map((e) => PostModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      emit(ExploreSuccess(posts: posts));
    } catch (e) {
      emit(ExploreFailure(errorMessage: e.toString()));
    }
  }
}
