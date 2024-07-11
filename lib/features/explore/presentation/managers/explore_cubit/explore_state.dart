part of 'explore_cubit.dart';

@immutable
sealed class ExploreState {}

final class ExploreInitial extends ExploreState {}

final class ExploreLoading extends ExploreState {}

final class ExploreFailure extends ExploreState {
  final String errorMessage;
  ExploreFailure({required this.errorMessage});
}

final class ExploreSuccess extends ExploreState {
  final List<PostModel> posts;
  ExploreSuccess({required this.posts});
}
