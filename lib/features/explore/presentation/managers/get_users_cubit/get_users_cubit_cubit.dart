import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/constants.dart';
import 'package:instagram_clone/features/add_post_and_reels/data/models/user_model.dart';
import 'package:meta/meta.dart';

part 'get_users_cubit_state.dart';

class GetUsersCubitCubit extends Cubit<GetUsersCubitState> {
  GetUsersCubitCubit() : super(GetUsersCubitInitial());

  Future<void> getUsers({required String userName}) async {
    emit(GetUsersCubitLoading());
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection(kUsersCollectionReference);
      QuerySnapshot querySnapshot =
          await users.where(kUserName, isGreaterThanOrEqualTo: userName).get();

      List<UserModel> usersList = [];
      for (var doc in querySnapshot.docs) {
        usersList.add(UserModel.fromJson(doc.data()));
      }
      emit(GetUsersCubitSuccess(users: usersList));
    } catch (e) {
      emit(GetUsersCubitFailure(errorMessage: e.toString()));
    }
  }
}
