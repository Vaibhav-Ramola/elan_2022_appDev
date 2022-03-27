class MsgInstance {
  final String textMsg;
  final bool sentByMe;
  final DateTime dateTime;

  const MsgInstance({
    required this.dateTime,
    required this.sentByMe,
    required this.textMsg,
  });
}
