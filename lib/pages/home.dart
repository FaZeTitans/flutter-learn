import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/post_view.dart';
import 'package:flutter_application_1/providers/post_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("MySocialLife"),
      ),
      body: ListView.builder(
        itemCount: postProvider.posts.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final post = postProvider.posts[index];
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: PostView(post: post));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/addPost");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
