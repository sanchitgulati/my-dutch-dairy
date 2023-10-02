import 'package:diary_app/dairy_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dutch Dairy'),
        automaticallyImplyLeading: false, // This line removes the back button;
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Navigator.of(context).pushReplacementNamed('/calendar');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
