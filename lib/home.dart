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
        title: Text('My Dutch Dairy'),
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
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with your desired number of sections
              itemBuilder: (context, index) {
                // Generate sample data for each section block
                final blockDate = now.add(Duration(days: index));
                final formattedBlockDate =
                    "${blockDate.day}/${blockDate.month}/${blockDate.year}";
                final blockHeading = "Section $index";

                return Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedBlockDate,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        blockHeading,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/calendar');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
