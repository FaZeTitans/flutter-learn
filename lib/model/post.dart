class Post {
  final int id;
  final String content;
  final String imageUrl;
  final String username;
  final String? location;
  final DateTime? date;
  final String? weather;
  final List<int> likes;
  final List<int> shares;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.imageUrl,
    required this.content,
    required this.username,
    this.location,
    this.date,
    this.weather,
    List<int>? likes,
    List<int>? shares,
    List<Comment>? comments,
  })  : likes = likes ?? [],
        shares = shares ?? [],
        comments = comments ?? [];

  int get likesCount => likes.length;
  int get sharesCount => shares.length;
  int get commentsCount => comments.length;

  bool isLikedBy(int userId) => likes.contains(userId);

  void toggleLike(int userId) {
    if (isLikedBy(userId)) {
      likes.remove(userId);
    } else {
      likes.add(userId);
    }
  }

  void addComment(Comment comment) {
    comments.add(comment);
  }

  void addShare(int userId) {
    if (!shares.contains(userId)) {
      shares.add(userId);
    }
  }
}

class Comment {
  final int userId;
  final String username;
  final String content;
  final List<int> likes;

  Comment({
    required this.userId,
    required this.username,
    required this.content,
    List<int>? likes,
  }) : likes = likes ?? [];

  int get likesCount => likes.length;

  bool isLikedBy(int userId) => likes.contains(userId);

  void toggleLike(int userId) {
    if (isLikedBy(userId)) {
      likes.remove(userId);
    } else {
      likes.add(userId);
    }
  }
}
