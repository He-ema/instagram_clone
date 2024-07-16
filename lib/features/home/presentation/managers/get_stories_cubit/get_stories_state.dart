part of 'get_stories_cubit.dart';

@immutable
sealed class GetStoriesState {}

final class GetStoriesInitial extends GetStoriesState {}

final class GetStoriesLoading extends GetStoriesState {}

final class GetStoriesFailure extends GetStoriesState {
  final String errorMessage;

  GetStoriesFailure({required this.errorMessage});
}

final class GetStoriesSuccess extends GetStoriesState {
  final List<StoryModel> stories;
  final StoryModel? currentUSerStories;

  GetStoriesSuccess({required this.stories, this.currentUSerStories});
}
