part of 'get_profile_data_cubit.dart';

@immutable
sealed class GetProfileDataState {}

final class GetProfileDataInitial extends GetProfileDataState {}

final class GetProfileDataLoading extends GetProfileDataState {}

final class GetProfileDataFailure extends GetProfileDataState {
  final String errorMessage;

  GetProfileDataFailure({required this.errorMessage});
}

final class GetProfileDataSuccess extends GetProfileDataState {
  final UserModel userModel;
  final List<PostModel> posts;
  GetProfileDataSuccess({required this.userModel, required this.posts});
}
