import 'tuts_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'loading_screen.dart'; // Import the loading screen
import 'home_page.dart'; // Import the home page

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Dutch Dairy',
      initialRoute: '/', // Set the initial route to the loading screen
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const LoadingScreen(), // Route to the loading screen
        '/next': (context) => const TutsPage(), // Route to the next screen
      },
    );
  }
}
