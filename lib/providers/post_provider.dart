import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/log_provider.dart';
import 'package:provider/provider.dart';

class PostProvider extends ChangeNotifier {
  final int postId;

  PostProvider({required this.postId});

  List<int> _likes = [];
  bool _isLiked = false;

  List<Map<String, dynamic>> _comments = [];

  List<int> _shares = [];

  List<int> get likes => _likes;
  int get likesCount => _likes.length;
  bool get isLiked => _isLiked;

  List<Map<String, dynamic>> get comments => _comments;
  int get commentsCount => _comments.length;

  List<int> get shares => _shares;
  int get sharesCount => _shares.length;

  void toggleLike(BuildContext context) {
    // Get userid from LogProvider
    final logProvider = Provider.of<LogProvider>(context, listen: false);
    final userid = logProvider.userId;

    if (_isLiked) {
      _likes.remove(userid);
    } else {
      _likes.add(userid);
    }

    _isLiked = !_isLiked;
    notifyListeners();
  }

  void addComment(BuildContext context, String comment) {
    // Get userid and username from LogProvider
    final logProvider = Provider.of<LogProvider>(context, listen: false);
    final userid = logProvider.userId;
    final username = logProvider.username;

    _comments.add({
      "userid": userid,
      "username": username,
      "comment": comment,
      "likes": [],
    });
    notifyListeners();
  }

  void addShare(BuildContext context) {
    // Get userid from LogProvider
    final logProvider = Provider.of<LogProvider>(context, listen: false);
    final userid = logProvider.userId;

    _shares.add(userid);
    notifyListeners();
  }
}
