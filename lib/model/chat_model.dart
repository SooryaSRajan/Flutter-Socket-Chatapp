class ChatModel {
  String message;
  DateTime? date;
  String sentBy;


  @override
  String toString() {
    return "Message: $message sent by $sentBy";
  }

  ChatModel({required this.message, required this.sentBy});
}
