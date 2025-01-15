import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/log_provider.dart';
import 'package:flutter_application_1/providers/post_provider.dart';
import 'package:provider/provider.dart';
class NewPostPage extends StatelessWidget {
  const NewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final logProvider = Provider.of<LogProvider>(context);

    var content = "";
    var imageUrl = "";

    return Scaffold(
        appBar: AppBar(
          title: const Text("New Post"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Image URL"),
                onChanged: (value) {
                  imageUrl = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Content"),
                onChanged: (value) {
                  content = value;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  postProvider.addPost(
                      imageUrl, content, logProvider.username!);
                  Navigator.of(context).pop();
                },
                child: const Text("Post"),
              ),
            ],
          ),
        ));
  }
}
