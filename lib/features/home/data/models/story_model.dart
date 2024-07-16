import 'package:instagram_clone/constants.dart';

class StoryModel {
  final String image;
  final String userName;
  final String email;
  final List stories;

  StoryModel(
      {required this.image,
      required this.userName,
      required this.email,
      required this.stories});

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      image: json[kImage],
      userName: json[kUserName],
      email: json[kEmail],
      stories: json[kStories],
    );
  }
}
