import 'package:diary_app/data_store.dart';
import 'package:diary_app/journal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DiaryList extends StatelessWidget {
  const DiaryList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Journal>>(
      future: context.read<DataStore>().getDataFromDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle the button click to "write your first story"
              },
              child: const Text('Write your first story'),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final row = snapshot.data![index];
              final dateTime = DateTime.fromMillisecondsSinceEpoch(
                  row.millisecondsSinceEpoch);
              final formattedBlockDate = DateFormat('EEEE, MMMM d')
                  .format(dateTime); // Format the date
              final blockHeading = row.heading;
              final blockText = row.text;

              return Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
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
                    Text(
                      blockText,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
