import 'package:flutter/material.dart';
import 'view/user/user_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter sqflite usage',
      theme: ThemeData.dark(),
      home: const UserList(),
    );
  }
}
