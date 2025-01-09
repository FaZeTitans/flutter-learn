import 'package:flutter/material.dart';
import '../model/message.dart';

class ChatService extends ChangeNotifier {
  final List<Message> _messages = [];
  
  List<Message> getMessages(String userId1, String userId2) {
    return _messages
        .where((msg) =>
            (msg.senderId == userId1 && msg.receiverId == userId2) ||
            (msg.senderId == userId2 && msg.receiverId == userId1))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  void sendMessage(String senderId, String receiverId, String content) {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: senderId,
      receiverId: receiverId,
      content: content,
      timestamp: DateTime.now(),
    );
    
    _messages.add(message);
    notifyListeners();
  }
}
