import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/post.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Post(postId: index),
          );
        });
  }
}
