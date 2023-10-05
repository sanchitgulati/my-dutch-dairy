import 'package:diary_app/data_store.dart';
import 'package:diary_app/database_helper.dart';
import 'package:diary_app/home.dart';
import 'package:diary_app/glossary.dart';
import 'notepad.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
  // this step, it will use the sqlite version available on the system.
  if (Platform.isAndroid) {
    // Android-specific code
  } else {
    databaseFactory = databaseFactoryFfi;
  }
  DatabaseHelper databaseHelper = DatabaseHelper();
  await databaseHelper.init();

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
        //   // scaffoldBackgroundColor: Colors.blueGrey[100],
        //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   // textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.purple)),
        useMaterial3: true,
      ),

      routes: {
        '/': (context) => const MyHomePage(),
        '/notepad': (context) => const Notepad(), // Route to the next screen
        '/vocab': (context) => const Glossary()
      },
    );
  }
}
