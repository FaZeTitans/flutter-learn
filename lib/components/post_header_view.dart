import 'dart:developer';
import 'package:flutter/material.dart';
import '../pages/profile.dart';

class PostHeaderView extends StatelessWidget {
  final String? location;
  final String? weather;

  const PostHeaderView({super.key, this.location, this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(
                    userId: "1",
                    username: "John Doe",
                    profilePicture: "https://placecats.com/100/100",
                  ),
                ),
              );
            },
            child: const CircleAvatar(
              radius: 20,
              foregroundImage: NetworkImage("https://placecats.com/100/100"),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("John Doe"),
              Text(
                "2 hours ago${location != null ? " - $location › $weather" : ""}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              log("More pressed");
            },
          ),
        ],
      ),
    );
  }
}
