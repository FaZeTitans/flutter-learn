import 'dart:developer';
import 'package:flutter/material.dart';
import '../pages/profile.dart';

class PostHeaderView extends StatelessWidget {
  final String? username;
  final String? location;
  final String? weather;

  const PostHeaderView({
    super.key,
    this.location,
    this.weather,
    this.username,
  });

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
                  builder: (context) => ProfilePage(
                    userId: "1",
                    username: username ?? "Anonymous",
                    profilePicture: "https://avatar.iran.liara.run/public",
                  ),
                ),
              );
            },
            child: const CircleAvatar(
              radius: 20,
              foregroundImage:
                NetworkImage("https://avatar.iran.liara.run/public"),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username ?? "Anonymous"),
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
