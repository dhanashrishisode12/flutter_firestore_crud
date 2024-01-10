import 'package:flutter/material.dart';
import 'package:flutter_firestore_crud/pages/home_page.dart';
import 'package:flutter_firestore_crud/singleton.dart';

void main() async {
  //no binding has yet been initialized, the [WidgetsFlutterBinding]
  // class is used to create and initialize one.
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase using the singleton class
  await FirebaseSingleton.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // final Future<FirebaseApp> _initilization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firestore CRUD',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
