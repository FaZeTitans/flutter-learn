import 'package:flutter/material.dart';
import 'chat.dart';

class ProfilePage extends StatelessWidget {
  final String userId;
  final String username;
  final String profilePicture;

  const ProfilePage({
    super.key,
    required this.userId,
    required this.username,
    required this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 50,
              foregroundImage: NetworkImage(profilePicture),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            username,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverId: userId,
                    receiverName: username,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.chat),
            label: const Text('Let\'s Chat'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
