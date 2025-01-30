import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teste_wk_app/screens/home/home_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wk_teste_app',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white, brightness: Brightness.light)),
      home: const HomeScreen(),
    );
  }
}
