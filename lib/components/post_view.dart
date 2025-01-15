import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/post_header_view.dart';
import 'package:flutter_application_1/components/post_interactions_view.dart';
import 'package:flutter_application_1/model/post.dart';

class PostView extends StatelessWidget {
  final Post post;

  const PostView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostHeaderView(
            location: post.location,
            weather: post.weather,
            username: post.username),
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(post.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.all(8), child: Text(post.content)),
        PostInteractionsView(post: post),
      ],
    );
  }
}
