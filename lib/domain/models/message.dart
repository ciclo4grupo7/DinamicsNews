class ANewMessage {
  String sender, message;
  String? reference;
  int? timestamp;

  ANewMessage(
      {required this.message,
      required this.sender,
      this.reference,
      this.timestamp});

  factory ANewMessage.fromJson(Map<String, dynamic> map) {
    final data = map["data"] ?? map;
    return ANewMessage(
        message: data['message'],
        sender: data['sender'],
        timestamp: data['timestamp'],
        reference: map['ref'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "sender": sender,
      "timestamp": timestamp ?? DateTime.now().millisecondsSinceEpoch,
    };
  }
}
