// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCXvvU70J7JjuTHujDk_yPfEdF6JGYMcMQ",
      appId: "1:487554726637:android:b230ffb076698ae375aae4",
      messagingSenderId: "487554726637",
      projectId: "487554726637",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Delf Coffee",
      home: const SignInScreen(),
    );
  }
}
