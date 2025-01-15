import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/post.dart';
import 'package:flutter_application_1/services/location_service.dart';
import 'package:flutter_application_1/services/weather_service.dart';

class PostProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Post> _posts = [];

  List<Post> get posts => _posts;

  PostProvider() {
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    _firestore.collection('posts').snapshots().listen((snapshot) {
      if (snapshot.docs.isEmpty) {
        _posts = [];
        notifyListeners();
        return;
      }

      _posts = snapshot.docs.map((doc) {
        final data = doc.data();
        return Post(
          id: doc.id,
          content: data['content'],
          imageUrl: data['imageUrl'],
          username: data['username'],
          likes: List<String>.from(data['likes'] ?? []),
          shares: List<String>.from(data['shares'] ?? []),
          comments: (data['comments'] as List<dynamic>?)
                  ?.map((comment) => Comment(
                        userId: comment['userId'],
                        username: comment['username'],
                        content: comment['content'],
                      ))
                  .toList() ??
              [],
          location: data['location'],
          date: (data['date'] as Timestamp).toDate(),
          weather: data['weather'],
        );
      }).toList();
      notifyListeners();
    });
  }

  Future<void> addPost(String imageUrl, String content, String username) async {
    var position = await _locationService.getCurrentLocation();
    var city = await _locationService.getCityFromCoordinates(position);

    Map<String, dynamic> weatherData =
        await _weatherService.fetchWeatherData(city);

    final post = {
      'content': content,
      'imageUrl': imageUrl,
      'username': username,
      'location': city,
      'date': DateTime.now(),
      'weather': weatherData['weather'][0]['main'],
      'likes': [],
      'shares': [],
      'comments': [],
    };

    await _firestore.collection('posts').add(post);
    notifyListeners();
  }

  Future<void> toggleLike(String postId, String userId) async {
    final postRef = _firestore.collection('posts').doc(postId);
    final doc = await postRef.get();

    if (!doc.exists) return;

    final likes = List<String>.from(doc.data()?['likes'] ?? []);
    if (likes.contains(userId)) {
      likes.remove(userId);
    } else {
      likes.add(userId);
    }

    await postRef.update({'likes': likes});
    notifyListeners();
  }

  Future<void> addComment(String postId, Comment comment) async {
    final postRef = _firestore.collection('posts').doc(postId);
    final doc = await postRef.get();

    if (!doc.exists) return;

    final comments = (doc.data()?['comments'] as List<dynamic>?) ?? [];
    comments.add({
      'userId': comment.userId,
      'username': comment.username,
      'content': comment.content,
    });

    await postRef.update({'comments': comments});
    notifyListeners();
  }

  Future<void> addShare(String postId, String userId) async {
    final postRef = _firestore.collection('posts').doc(postId);
    final doc = await postRef.get();

    if (!doc.exists) return;

    final shares = List<String>.from(doc.data()?['shares'] ?? []);
    if (!shares.contains(userId)) {
      shares.add(userId);
    }

    await postRef.update({'shares': shares});
    notifyListeners();
  }
}
