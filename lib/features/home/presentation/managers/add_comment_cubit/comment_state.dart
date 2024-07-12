part of 'comment_cubit.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentFailure extends CommentState {
  final String errorMessage;

  CommentFailure({required this.errorMessage});
}

final class CommentSuccess extends CommentState {}
