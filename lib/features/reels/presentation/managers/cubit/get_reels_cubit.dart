import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/constants.dart';
import 'package:instagram_clone/features/reels/data/models/reel_model.dart';
import 'package:meta/meta.dart';

part 'get_reels_state.dart';

class GetReelsCubit extends Cubit<GetReelsState> {
  GetReelsCubit() : super(GetReelsInitial());

  Future<void> getReels() async {
    emit(GetReelsLoading());
    emit(GetReelsLoading());
    CollectionReference reelsCollection =
        FirebaseFirestore.instance.collection(kReelsCollectionReference);

    reelsCollection.orderBy(kDate, descending: true).snapshots().listen(
      (QuerySnapshot reelsSnapshot) {
        List<ReelModel> reels = reelsSnapshot.docs
            .map((e) => ReelModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        emit(GetReelsSuccess(reels: reels));
      },
      onError: (e) {
        emit(GetReelsFailure(errorMessage: e.toString()));
      },
    );
  }
}
