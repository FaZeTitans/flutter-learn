import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/post_header.dart';
import 'package:flutter_application_1/components/post_interactions.dart';

class Post extends StatelessWidget {
  final int postId;

  const Post({super.key, required this.postId});

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PostHeader(),
        const Placeholder(
          fallbackHeight: 300,
          color: Colors.red,
        ),
        PostInteractions(postId: postId),
      ],
    );
  }
}