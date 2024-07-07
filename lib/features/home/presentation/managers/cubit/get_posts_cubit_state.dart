part of 'get_posts_cubit_cubit.dart';

@immutable
sealed class GetPostsCubitState {}

final class GetPostsCubitInitial extends GetPostsCubitState {}

final class GetPostsCubitLoading extends GetPostsCubitState {}

final class GetPostsCubitFailure extends GetPostsCubitState {
  final String errorMessage;

  GetPostsCubitFailure({required this.errorMessage});
}

final class GetPostsCubitSuccess extends GetPostsCubitState {
  final List<PostModel> posts;
  GetPostsCubitSuccess({required this.posts});
}
