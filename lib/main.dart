import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/new_post.dart';
import 'package:flutter_application_1/pages/signup.dart';
import 'package:flutter_application_1/providers/log_provider.dart';
import 'package:flutter_application_1/providers/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login.dart'; // Import your LoginPage
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: const LoginPage(),
      routes: {
        "/home": (context) => const HomePage(),
        "/signup": (context) => const SignupPage(),
        "/addPost": (context) => const NewPostPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/home") {
          return MaterialPageRoute(
            builder: (context) => const HomePage(),
            settings: settings,
            maintainState: false,
          );
        }
        return null;
      },
    );
  }
}
