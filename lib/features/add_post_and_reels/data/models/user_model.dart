import 'package:instagram_clone/constants.dart';

class UserModel {
  final String userName, bio, image, email;
  final List followers, following;

  UserModel(
      {required this.userName,
      required this.bio,
      required this.image,
      required this.email,
      required this.followers,
      required this.following});

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      userName: jsonData[kUserName],
      bio: jsonData[kBio],
      image: jsonData[kImage],
      email: jsonData[kEmail],
      followers: jsonData[kFollowers],
      following: jsonData[kFollowing],
    );
  }
}
