import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/new_post.dart';
import 'package:flutter_application_1/providers/log_provider.dart';
import 'package:flutter_application_1/providers/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/pages/home.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LogProvider()),
      ChangeNotifierProvider(create: (_) => PostProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "MySocialLife",
      home: const HomePage(),
      routes: {
        "/addPost": (context) => const NewPostPage(),
      },
    );
  }
}
