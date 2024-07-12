import 'package:instagram_clone/constants.dart';

class CommentModel {
  final String comemnt;
  final String userName;
  final String userProfileImage;
  final String commentId;

  CommentModel(
      {required this.comemnt,
      required this.userName,
      required this.userProfileImage,
      required this.commentId});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      comemnt: json[kComment],
      userName: json[kUserName],
      userProfileImage: json[kUserProfileImage],
      commentId: json[kCommentId],
    );
  }
}
