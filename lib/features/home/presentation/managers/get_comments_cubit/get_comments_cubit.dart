import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/constants.dart';
import 'package:instagram_clone/features/home/data/models/comment_model.dart';
import 'package:meta/meta.dart';

part 'get_comments_state.dart';

class GetCommentsCubit extends Cubit<GetCommentsState> {
  GetCommentsCubit() : super(GetCommentsInitial());

  Future<void> getComments({required String type, required String uuid}) async {
    CollectionReference commentsCollection = FirebaseFirestore.instance
        .collection(type)
        .doc(uuid)
        .collection(kCommentsCollectionReference);

    commentsCollection.snapshots().listen((snapshot) {
      List<CommentModel> comments = snapshot.docs
          .map((doc) =>
              CommentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      emit(GetCommentsSuccess(comments: comments));
    }, onError: (e) {
      emit(GetCommentsFailure(errorMessage: e.toString()));
    });
  }
}
