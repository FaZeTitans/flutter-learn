import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogProvider extends ChangeNotifier {
  String? _userId;
  String? _username;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool get isLoggedIn => _userId != null;
  String? get userId => _userId;
  String? get username => _username;

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('Connecté: ${userCredential.user}');

      if (userCredential.user != null) {
        await getUserProfile(userCredential.user!);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void logout() {
    _userId = null;
    _username = null;
    notifyListeners();
  }

  Future<void> signup(String email, String password, String confirmPassword,
      String username) async {
    if (password != confirmPassword) {
      throw Exception("Les mots de passes sont différents");
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('Inscrit et connecté: ${userCredential.user}');

      if (userCredential.user != null) {
        _userId = userCredential.user!.uid;
        _username = username;

        await createUserProfile(userCredential.user!, username);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUserProfile(User user, String username) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email,
        'username': username,
        'photoURL': 'https://avatar.iran.liara.run/public',
        'createdAt': FieldValue.serverTimestamp(),
      });

      debugPrint('User profile created for UID: ${user.uid}');
    } catch (e) {
      debugPrint('Error creating user profile: $e');
      throw Exception('Failed to create user profile');
    }
  }

  Future<void> getUserProfile(User user) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(user.uid).get();

      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;

        _userId = user.uid;
        _username = userData['username'] ?? 'Unknown';

        debugPrint('User profile loaded for UID: ${user.uid}');
      } else {
        debugPrint('No profile found for UID: ${user.uid}');
        throw Exception('User profile does not exist');
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error retrieving user profile: $e');
      throw Exception('Failed to retrieve user profile');
    }
  }
}
