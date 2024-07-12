import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/constants.dart';
import 'package:instagram_clone/features/add_post_and_reels/presentation/managers/add_post_cubit/add_post_cubit.dart';
import 'package:meta/meta.dart';

import '../../../data/models/post_model.dart';

part 'get_posts_cubit_state.dart';

class GetPostsCubitCubit extends Cubit<GetPostsCubitState> {
  GetPostsCubitCubit() : super(GetPostsCubitInitial());

  Future<void> getPosts() async {
    CollectionReference chat =
        FirebaseFirestore.instance.collection(kPostsCollectionReference);
    chat.orderBy(kDate, descending: true).snapshots().listen((event) {
      emit(GetPostsCubitLoading());
      List<PostModel> posts = [];
      for (var doc in event.docs) {
        posts.add(PostModel.fromJson(doc));
      }

      emit(GetPostsCubitSuccess(posts: posts));
    });
  }
}
