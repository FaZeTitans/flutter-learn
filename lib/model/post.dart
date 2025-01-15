class Post {
  final String id;
  final String content;
  final String imageUrl;
  final String username;
  final String? location;
  final DateTime? date;
  final String? weather;
  final List<String> likes;
  final List<String> shares;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.imageUrl,
    required this.content,
    required this.username,
    this.location,
    this.date,
    this.weather,
    List<String>? likes,
    List<String>? shares,
    List<Comment>? comments,
  })  : likes = likes ?? [],
        shares = shares ?? [],
        comments = comments ?? [];

  int get likesCount => likes.length;
  int get sharesCount => shares.length;
  int get commentsCount => comments.length;

  bool isLikedBy(String userId) => likes.contains(userId);

  void toggleLike(String userId) {
    if (isLikedBy(userId)) {
      likes.remove(userId);
    } else {
      likes.add(userId);
    }
  }

  void addComment(Comment comment) {
    comments.add(comment);
  }

  void addShare(String userId) {
    if (!shares.contains(userId)) {
      shares.add(userId);
    }
  }
}

class Comment {
  final String userId;
  final String username;
  final String content;
  final List<String> likes;

  Comment({
    required this.userId,
    required this.username,
    required this.content,
    List<String>? likes,
  }) : likes = likes ?? [];

  int get likesCount => likes.length;

  bool isLikedBy(String userId) => likes.contains(userId);

  void toggleLike(String userId) {
    if (isLikedBy(userId)) {
      likes.remove(userId);
    } else {
      likes.add(userId);
    }
  }
}
