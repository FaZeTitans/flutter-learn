import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/post.dart';
import 'package:flutter_application_1/providers/log_provider.dart';
import 'package:flutter_application_1/services/location_service.dart';
import 'package:flutter_application_1/services/weather_service.dart';

class PostProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();

  final List<Post> _posts = [
    Post(
      id: 1,
      content: "Hello world! This is my first post.",
      imageUrl: "https://picsum.photos/200",
      username: "JohnDoe",
      likes: [1, 2],
      shares: [3],
      comments: [
        Comment(userId: 2, username: "JaneDoe", content: "Nice post!"),
      ],
    ),
    Post(
      id: 2,
      content: "Having a great day at the beach! 🌞",
      imageUrl: "https://picsum.photos/200",
      username: "JaneDoe",
      likes: [2, 3],
      shares: [],
      comments: [
        Comment(userId: 1, username: "JohnDoe", content: "Looks amazing!"),
      ],
    ),
    Post(
      id: 3,
      content: "Just finished reading a great book.",
      imageUrl: "https://picsum.photos/200",
      username: "JohnDoe",
      likes: [],
      shares: [],
      comments: [],
    ),
    Post(
      id: 4,
      content: "Just finished reading a great book.",
      imageUrl: "https://picsum.photos/200",
      username: "JohnDoe",
      likes: [],
      shares: [],
      comments: [],
    ),
    Post(
      id: 5,
      content: "Just finished reading a great book.",
      imageUrl: "https://picsum.photos/200",
      username: "JohnDoe",
      likes: [],
      shares: [],
      comments: [],
    ),
    Post(
      id: 6,
      content: "Just finished reading a great book.",
      imageUrl: "https://picsum.photos/200",
      username: "JohnDoe",
      likes: [],
      shares: [],
      comments: [],
    ),
    Post(
      id: 7,
      content: "Just finished reading a great book.",
      imageUrl: "https://picsum.photos/200",
      username: "JohnDoe",
      likes: [],
      shares: [],
      comments: [],
    ),
    Post(
      id: 8,
      content: "Just finished reading a great book.",
      imageUrl: "https://picsum.photos/200",
      username: "JohnDoe",
      likes: [],
      shares: [],
      comments: [],
    ),
    Post(
      id: 9,
      content: "Just finished reading a great book.",
      imageUrl: "https://picsum.photos/200",
      username: "JohnDoe",
      likes: [],
      shares: [],
      comments: [],
    ),
    Post(
      id: 10,
      content: "Just finished reading a great book.",
      imageUrl: "https://picsum.photos/200",
      username: "JohnDoe",
      likes: [],
      shares: [],
      comments: [],
    ),
  ];

  List<Post> get posts => _posts;

  void addPost(imageUrl, content, username) async {
    var position = await _locationService.getCurrentLocation();
    var city = await _locationService.getCityFromCoordinates(position);

    Map<String, dynamic> weatherData =
        await _weatherService.fetchWeatherData(city);

    _posts.add(Post(
      id: _posts.length + 1,
      imageUrl: imageUrl,
      content: content,
      username: username,
      location: city,
      date: DateTime.now(),
      weather: weatherData["weather"][0]['main'],
    ));
    notifyListeners();
  }

  void toggleLike(int postId, int userId) {
    final post = _posts.firstWhere((p) => p.id == postId);
    post.toggleLike(userId);
    notifyListeners();
  }

  void addComment(int postId, Comment comment) {
    final post = _posts.firstWhere((p) => p.id == postId);
    post.addComment(comment);
    notifyListeners();
  }

  void addShare(int postId, int userId) {
    final post = _posts.firstWhere((p) => p.id == postId);
    post.addShare(userId);
    notifyListeners();
  }
}
