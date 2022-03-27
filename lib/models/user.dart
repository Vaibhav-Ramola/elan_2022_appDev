class User {
  final String userId;
  bool isOnline;
  final String userName;

  User({
    required this.userId,
    required this.isOnline,
    required this.userName,
  });

  String get userid {
    return userId;
  }
}
