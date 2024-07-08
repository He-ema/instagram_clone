import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/constants.dart';

class PostModel {
  final String username;
  final String location;
  final String image;
  final String caption;
  final String profileImage;
  final String email;
  final String userId;
  final String postId;
  final Timestamp date;
  final List likes;

  PostModel(
      {required this.username,
      required this.location,
      required this.image,
      required this.caption,
      required this.profileImage,
      required this.email,
      required this.userId,
      required this.postId,
      required this.date,
      required this.likes});

  factory PostModel.fromJson(jsonData) {
    return PostModel(
      username: jsonData[kUserName],
      location: jsonData[kLocation],
      image: jsonData[kImage],
      caption: jsonData[kCaption],
      profileImage: jsonData[kUserProfileImage],
      email: jsonData[kEmail],
      userId: jsonData[kUserId],
      postId: jsonData[kPostId],
      date: jsonData[kDate],
      likes: jsonData[kLikes],
    );
  }
}
