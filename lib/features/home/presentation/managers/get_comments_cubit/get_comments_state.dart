part of 'get_comments_cubit.dart';

@immutable
sealed class GetCommentsState {}

final class GetCommentsInitial extends GetCommentsState {}

final class GetCommentsSuccess extends GetCommentsState {
  final List<CommentModel> comments;

  GetCommentsSuccess({required this.comments});
}

final class GetCommentsFailure extends GetCommentsState {
  final String errorMessage;

  GetCommentsFailure({required this.errorMessage});
}
