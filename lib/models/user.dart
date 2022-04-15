class User {
  String userId;
  bool isOnline;
  String userName;

  User({
    required this.userId,
    required this.isOnline,
    required this.userName,
  });

  String get userid {
    return userId;
  }
}
