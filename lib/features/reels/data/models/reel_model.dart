import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/constants.dart';

class ReelModel {
  final String video, caption, email, postId, profileImage, userName, userId;
  final List likes;
  final Timestamp date;

  ReelModel(
      {required this.video,
      required this.caption,
      required this.email,
      required this.postId,
      required this.profileImage,
      required this.userName,
      required this.userId,
      required this.likes,
      required this.date});

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      video: json[kReelVideo],
      caption: json[kCaption],
      email: json[kEmail],
      postId: json[kPostId],
      profileImage: json[kUserProfileImage],
      userName: json[kUserName],
      userId: json[kUserId],
      likes: json[kLikes],
      date: json[kDate],
    );
  }
}
