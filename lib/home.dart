import 'package:diary_app/dairy_list.dart';
import 'package:diary_app/data_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Get the current date
    final now = DateTime.now();
    final formattedDate =
        DateFormat('EEEE, MMMM d').format(now); // Format the date
// Determine the greeting based on the time
    int hour = now.hour;
    String greeting = '';
    if (hour >= 0 && hour < 12) {
      greeting = 'Goedemorgen';
    } else if (hour >= 12 && hour < 17) {
      greeting = 'Goedemiddag';
    } else {
      greeting = 'Goedenavond';
    }

    return WillPopScope(
      onWillPop: () async {
        return _onWillPop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Dutch Dairy'),
          automaticallyImplyLeading:
              false, // This line removes the back button;
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () => {
                Navigator.of(context).pushNamed('/translate'),
              },
              child: const Text('Translate'),
            ),
            const SizedBox(
              height: 50,
            ),
            // Section with today's date and greeting
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      greeting,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Scrollable view with section blocks
            const Expanded(
              child: DiaryList(),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<DataStore>().newStory();
            Navigator.of(context).pushNamed('/notepad');
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showPlatformDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => {Navigator.of(context).pop(false)},
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => {exitApp(context)},
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void exitApp(context) {
    if (Platform.isAndroid) {
      SystemNavigator.pop(); // This line exits the app on Android.
    } else {
      // Handle app exit for other platforms, if necessary.
      // On iOS, you can't programmatically exit the app.
      // You can leave this part empty or provide alternative handling.
      return Navigator.of(context).pop(true);
    }
  }
}
