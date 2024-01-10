import 'package:firebase_core/firebase_core.dart';

class FirebaseSingleton {
  static final FirebaseSingleton _instance = FirebaseSingleton._internal();

  factory FirebaseSingleton() {
    return _instance;
  }

  FirebaseSingleton._internal();

  static Future<void> initialize() async {
    try {
      // Ensure Firebase is initialized
      await Firebase.initializeApp();
      print("Firebase initialized successfully");
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }
}
