import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/post_provider.dart';
import 'package:provider/provider.dart';

class LikeProvider extends ChangeNotifier {
  int _likes = 0;

  int get likes => _likes;

  void incrementLikes() {
    _likes++;
    notifyListeners();
  }
}

class PostInteractions extends StatelessWidget {
  final int postId;

  const PostInteractions({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return ChangeNotifierProvider(
        create: (_) => PostProvider(postId: postId),
        child: Consumer<PostProvider>(builder: (context, postProvider, child) {
          return Row(
            children: [
              Column(
                children: [
                  IconButton(
                    icon: postProvider.isLiked
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border),
                    onPressed: () {
                      postProvider.toggleLike(context);
                    },
                  ),
                  Text("${postProvider.likesCount}"),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      postProvider.addComment(context, "This is a comment");
                    },
                  ),
                  Text("${postProvider.commentsCount}"),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.ios_share),
                    onPressed: () {
                      postProvider.addShare(context);
                    },
                  ),
                  Text("${postProvider.sharesCount}"),
                ],
              )
            ],
          );
        }));
  }
}
