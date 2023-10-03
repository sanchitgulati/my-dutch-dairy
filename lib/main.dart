import 'dart:io';

import 'package:diary_app/data_store.dart';
import 'package:diary_app/database_helper.dart';
import 'package:diary_app/home.dart';
import 'package:diary_app/journal.dart';
import 'package:diary_app/vocab.dart';
import 'calendar.dart';
import 'tuts_page.dart';
import 'package:flutter/material.dart';
import 'loading_screen.dart'; // Import the loading screen
import 'package:provider/provider.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
  // this step, it will use the sqlite version available on the system.
  databaseFactory = databaseFactoryFfi;
  DatabaseHelper databaseHelper = DatabaseHelper();
  await databaseHelper.init();
  databaseHelper.insert(Journal(
      millisecondsSinceEpoch: DateTime.now().microsecondsSinceEpoch,
      heading: "My First Story",
      text: "Jack and Jill went upto the hill"));

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
      // theme: ThemeData(
      //   // scaffoldBackgroundColor: Colors.blueGrey[100],
      //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   // textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.purple)),
      //   // useMaterial3: true,
      // ),

      routes: {
        '/': (context) =>
            SearchBarTableDemoHome(), // Route to the loading screen
        '/next': (context) => const TutsPage(), // Route to the next screen
        '/calendar': (context) => const Calendar(), // Route to the next screen
        '/home': (context) => MyHomePage()
      },
    );
  }
}
