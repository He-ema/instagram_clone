import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/constants.dart';
import 'package:instagram_clone/features/home/data/models/story_model.dart';
import 'package:meta/meta.dart';

part 'get_stories_state.dart';

class GetStoriesCubit extends Cubit<GetStoriesState> {
  GetStoriesCubit() : super(GetStoriesInitial());

  Future<void> getStories() async {
    emit(GetStoriesLoading());
    try {
      CollectionReference storiesCollection =
          FirebaseFirestore.instance.collection(kStoriesCollectionReference);
      storiesCollection.snapshots().listen((event) {
        List<StoryModel> stories = [];
        StoryModel? currentUSerStories;
        for (var doc in event.docs) {
          StoryModel story =
              StoryModel.fromJson(doc.data() as Map<String, dynamic>);
          if (story.email == FirebaseAuth.instance.currentUser!.email) {
            currentUSerStories = story;
          } else {
            stories.add(story);
          }
        }
        emit(GetStoriesSuccess(
            stories: stories, currentUSerStories: currentUSerStories));
      });
    } catch (e) {
      emit(GetStoriesFailure(errorMessage: e.toString()));
    }
  }
}
