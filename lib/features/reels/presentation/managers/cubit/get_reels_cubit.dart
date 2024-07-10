import 'package:bloc/bloc.dart';
import 'package:instagram_clone/features/reels/data/models/reel_model.dart';
import 'package:meta/meta.dart';

part 'get_reels_state.dart';

class GetReelsCubit extends Cubit<GetReelsState> {
  GetReelsCubit() : super(GetReelsInitial());
}
