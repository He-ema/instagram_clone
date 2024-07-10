part of 'get_reels_cubit.dart';

@immutable
sealed class GetReelsState {}

final class GetReelsInitial extends GetReelsState {}

final class GetReelsLoading extends GetReelsState {}

final class GetReelsFailure extends GetReelsState {}

final class GetReelsSuccess extends GetReelsState {
  final List<ReelModel> reels;

  GetReelsSuccess({required this.reels});
}
