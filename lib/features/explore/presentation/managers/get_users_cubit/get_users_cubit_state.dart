part of 'get_users_cubit_cubit.dart';

@immutable
sealed class GetUsersCubitState {}

final class GetUsersCubitInitial extends GetUsersCubitState {}

final class GetUsersCubitLoading extends GetUsersCubitState {}

final class GetUsersCubitFailure extends GetUsersCubitState {
  final String errorMessage;

  GetUsersCubitFailure({required this.errorMessage});
}

final class GetUsersCubitSuccess extends GetUsersCubitState {
  final List<UserModel> users;

  GetUsersCubitSuccess({required this.users});
}
