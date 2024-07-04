
class PostModel {
  final String postTitle;
  final String audioUrl;
  final String userEmail;
  final String nickname;
  final String profilePicUrl;
  final String dateCreated;
  final String boardName;

  PostModel({
    required this.postTitle,
    required this.audioUrl,
    required this.userEmail,
    required this.nickname,
    required this.profilePicUrl,
    required this.dateCreated,
    required this.boardName
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'audioUrl': audioUrl,
      'boardName': boardName,
      'profilePicUrl': profilePicUrl,
      'userEmail': userEmail,
      'postTitle': postTitle,
      'dateCreated': dateCreated,
    };
  }
}
