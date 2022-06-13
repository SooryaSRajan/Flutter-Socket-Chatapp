class ChatModel {
  String message;
  DateTime? date;
  bool isRightMessage;


  @override
  String toString() {
    return "Message: $message";
  }

  ChatModel({required this.message, required this.isRightMessage});
}
