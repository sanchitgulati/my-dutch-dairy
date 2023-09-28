import 'package:diary_app/data_store.dart';
import 'calendar.dart';
import 'tuts_page.dart';
import 'package:flutter/material.dart';
import 'loading_screen.dart'; // Import the loading screen

import 'package:provider/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataStore()),
      ],
      child: const MyApp(),
    ),
  );
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
        '/calendar': (context) => const Calendar(), // Route to the next screen
      },
    );
  }
}
