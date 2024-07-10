part of 'add_reel_cubit.dart';

@immutable
sealed class AddReelState {}

final class AddReelInitial extends AddReelState {}

final class AddReelLoading extends AddReelState {}

final class AddReelSuccess extends AddReelState {}

final class AddReelFailure extends AddReelState {
  final String errorMessage;

  AddReelFailure({required this.errorMessage});
}
