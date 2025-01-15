import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/post.dart';
import 'package:flutter_application_1/providers/log_provider.dart';
import 'package:flutter_application_1/providers/post_provider.dart';
import 'package:provider/provider.dart';

class PostInteractionsView extends StatelessWidget {
  final Post post;

  const PostInteractionsView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LogProvider>(context, listen: false);
    final postProvider = Provider.of<PostProvider>(context);

    return Row(
      children: [
        Column(
          children: [
            IconButton(
              icon: post.isLikedBy(user.userId ?? "")
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              onPressed: () {
                postProvider.toggleLike(post.id, user.userId!);
              },
            ),
            Text("${post.likesCount}"),
          ],
        ),
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.comment),
              onPressed: () {
                postProvider.addComment(
                    post.id,
                    Comment(
                        userId: user.userId!,
                        username: user.username!,
                        content: "Test"));
              },
            ),
            Text("${post.commentsCount}"),
          ],
        ),
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.ios_share),
              onPressed: () {
                postProvider.addShare(post.id, user.userId!);
              },
            ),
            Text("${post.sharesCount}"),
          ],
        )
      ],
    );
  }
}
