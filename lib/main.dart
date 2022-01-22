import 'package:amit_app/layout/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'layout/home/home.dart';
import 'shared/styles/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amit',
      theme: lightTheme,
      home: Home(),
    );
  }
}
